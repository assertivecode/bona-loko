#!/usr/bin/env node

import fs from 'node:fs';
import path from 'node:path';
import { execSync } from 'node:child_process';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const rootDir = path.resolve(__dirname, '../..');

export function loadDeployTargets() {
  const devopsPath = path.join(rootDir, 'devops', 'deploy-targets.json');
  const rootPath = path.join(rootDir, 'deploy-targets.json');

  if (fs.existsSync(devopsPath)) {
    return JSON.parse(fs.readFileSync(devopsPath, 'utf8'));
  }
  if (fs.existsSync(rootPath)) {
    return JSON.parse(fs.readFileSync(rootPath, 'utf8'));
  }
  throw new Error(`deploy-targets.json not found in ${devopsPath} or ${rootPath}`);
}

export function matchPathPattern(filePath, pattern) {
  const normalizedFile = filePath.replace(/\\/g, '/');
  const normalizedPattern = pattern.replace(/\\/g, '/');

  if (normalizedPattern.endsWith('/**')) {
    const prefix = normalizedPattern.slice(0, -3);
    return normalizedFile === prefix || normalizedFile.startsWith(prefix + '/');
  }
  if (normalizedPattern.startsWith('*.')) {
    const ext = normalizedPattern.slice(1);
    return normalizedFile.endsWith(ext);
  }
  return normalizedFile === normalizedPattern;
}

export function parseChangesetContent(content) {
  const frontmatterMatch = content.match(/^---\r?\n([\s\S]*?)\r?\n---/);
  if (!frontmatterMatch) {
    return { apps: {}, summary: content.trim() };
  }

  const frontmatterText = frontmatterMatch[1];
  const summary = content.slice(frontmatterMatch[0].length).trim();
  const apps = {};

  for (const line of frontmatterText.split('\n')) {
    const trimmed = line.trim();
    if (!trimmed) continue;
    const match = trimmed.match(/^["']?([^"':]+)["']?\s*:\s*(.+)$/);
    if (match) {
      const appName = match[1].trim();
      const bumpType = match[2].trim().replace(/^["']|["']$/g, '');
      apps[appName] = bumpType;
    }
  }

  return { apps, summary };
}

export function getChangedFilesFromGit(baseRef = 'origin/main', headRef = 'HEAD') {
  const modified = new Set();
  const diffCommands = [
    `git diff --name-only ${baseRef}...${headRef}`,
    `git diff --name-only ${baseRef} ${headRef}`,
    `git diff --name-only main...HEAD`,
    `git diff --name-only HEAD~1`
  ];

  for (const cmd of diffCommands) {
    try {
      const output = execSync(cmd, { cwd: rootDir, encoding: 'utf8', stdio: ['pipe', 'pipe', 'ignore'] });
      for (const line of output.split('\n')) {
        const file = line.trim();
        if (file) modified.add(file);
      }
      break;
    } catch {
      // Try next diff fallback
    }
  }

  try {
    const statusOutput = execSync('git status --porcelain', { cwd: rootDir, encoding: 'utf8' });
    for (const line of statusOutput.split('\n')) {
      const trimmed = line.trim();
      if (!trimmed) continue;
      let filePart = trimmed.slice(2).trim();
      if (filePart.includes('->')) {
        filePart = filePart.split('->')[1].trim();
      }
      filePart = filePart.replace(/^"|"$/g, '');
      if (filePart) modified.add(filePart);
    }
  } catch {
    // Ignore
  }

  return Array.from(modified);
}

export function evaluateRequiredApps(changedFiles, deployTargets) {
  const requiredApps = new Set();
  const ignored = deployTargets.ignoredPaths || [];

  for (const file of changedFiles) {
    const isIgnored = ignored.some(pattern => matchPathPattern(file, pattern));
    if (isIgnored) continue;

    for (const [appKey, appDef] of Object.entries(deployTargets.apps)) {
      if (appDef.active === false) continue;
      const matches = (appDef.paths || []).some(pattern => matchPathPattern(file, pattern));
      if (matches) {
        requiredApps.add(appKey);
      }
    }
  }

  return Array.from(requiredApps).sort();
}

export function evaluateDeclaredChangesets(changedFiles, customChangesetDir) {
  const changesetDir = customChangesetDir || path.join(rootDir, '.changeset');
  const declaredApps = new Set();
  const changesetFiles = [];

  const relevantFiles = (changedFiles || []).filter(file => {
    const normalized = file.replace(/\\/g, '/');
    return normalized.startsWith('.changeset/') && normalized.endsWith('.md') && !normalized.endsWith('README.md');
  });

  if (relevantFiles.length > 0) {
    for (const relFile of relevantFiles) {
      const fullPath = path.join(rootDir, relFile);
      if (fs.existsSync(fullPath)) {
        changesetFiles.push(fullPath);
      }
    }
  } else if (fs.existsSync(changesetDir)) {
    const files = fs.readdirSync(changesetDir);
    for (const file of files) {
      if (file.endsWith('.md') && file !== 'README.md') {
        changesetFiles.push(path.join(changesetDir, file));
      }
    }
  }

  for (const filePath of changesetFiles) {
    try {
      const content = fs.readFileSync(filePath, 'utf8');
      const { apps } = parseChangesetContent(content);
      for (const appKey of Object.keys(apps)) {
        declaredApps.add(appKey);
      }
    } catch (err) {
      console.warn(`⚠️ Warning: could not parse changeset ${filePath}: ${err.message}`);
    }
  }

  return {
    declaredApps: Array.from(declaredApps).sort(),
    changesetFiles
  };
}

export function validateChangesetMatch({ requiredApps, declaredApps }) {
  const requiredSet = new Set(requiredApps);
  const declaredSet = new Set(declaredApps);

  const missingApps = requiredApps.filter(app => !declaredSet.has(app));
  const extraApps = declaredApps.filter(app => !requiredSet.has(app));

  const isValid = missingApps.length === 0 && extraApps.length === 0;

  return {
    isValid,
    requiredApps,
    declaredApps,
    missingApps,
    extraApps
  };
}

async function runCli() {
  const args = process.argv.slice(2);
  let baseRef = 'origin/main';
  let headRef = 'HEAD';

  for (let i = 0; i < args.length; i++) {
    if (args[i] === '--base' && args[i + 1]) {
      baseRef = args[i + 1];
      i++;
    } else if (args[i] === '--head' && args[i + 1]) {
      headRef = args[i + 1];
      i++;
    }
  }

  console.log('====================================================');
  console.log('  Bona Loko CI — Changeset & Path Filter Validation');
  console.log('====================================================');
  console.log(`Comparing: ${baseRef} ... ${headRef}\n`);

  const deployTargets = loadDeployTargets();
  const changedFiles = getChangedFilesFromGit(baseRef, headRef);
  const requiredApps = evaluateRequiredApps(changedFiles, deployTargets);
  const { declaredApps, changesetFiles } = evaluateDeclaredChangesets(changedFiles);

  const result = validateChangesetMatch({ requiredApps, declaredApps });

  console.log(`📁 Total changed files: ${changedFiles.length}`);
  console.log(`📄 Changeset files detected: ${changesetFiles.length}`);
  console.log(`🎯 Required app deployments (by path filtering): [${result.requiredApps.join(', ') || 'none'}]`);
  console.log(`🏷️  Declared app deployments (in changesets):       [${result.declaredApps.join(', ') || 'none'}]\n`);

  if (result.isValid) {
    if (result.requiredApps.length === 0) {
      console.log('✅ Validation PASSED: No application code was modified (documentation/meta only). No changeset required.\n');
    } else {
      console.log(`✅ Validation PASSED: Changeset accurately and strictly matches modified apps: [${result.requiredApps.join(', ')}].\n`);
    }
    process.exit(0);
  } else {
    console.error('❌ Validation FAILED: Changeset does not strictly match modified application files!');

    if (result.missingApps.length > 0) {
      console.error(`\n🚨 MISSING DEPLOYMENT DECLARATIONS:`);
      console.error(`   The following apps had code changes, but are MISSING from the changeset:`);
      console.error(`   👉 [${result.missingApps.join(', ')}]`);
      console.error(`   Please run 'npm run changeset' to declare deployments for these apps.`);
    }

    if (result.extraApps.length > 0) {
      console.error(`\n🚨 UNNECESSARY / EXTRA DEPLOYMENT DECLARATIONS:`);
      console.error(`   The changeset declares deployments for apps that had NO code changes:`);
      console.error(`   👉 [${result.extraApps.join(', ')}]`);
      console.error(`   Changesets must declare ONLY the necessary deployments.`);
      console.error(`   Please remove the unneeded app tags from your changeset.`);
    }

    console.error('\n🚫 Pull request merge is BLOCKED until changeset matches path filtering exactly.\n');
    process.exit(1);
  }
}

if (process.argv[1] && path.resolve(process.argv[1]) === path.resolve(__filename)) {
  runCli().catch(err => {
    console.error(`\n❌ Fatal Error: ${err.message}`);
    process.exit(1);
  });
}
