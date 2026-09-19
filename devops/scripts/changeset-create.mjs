#!/usr/bin/env node

import fs from 'node:fs';
import path from 'node:path';
import { execSync } from 'node:child_process';
import readline from 'node:readline/promises';
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
  // Normalize Windows slashes
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

export function getModifiedFiles(baseBranch = 'origin/main') {
  const modified = new Set();

  // 1. Check uncommitted changes (staged + unstaged)
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
    // Ignore git status failure
  }

  // 2. Check committed diff against base branch
  const diffCommands = [
    `git diff --name-only ${baseBranch}...HEAD`,
    `git diff --name-only main...HEAD`,
    `git diff --name-only HEAD~1`
  ];

  for (const cmd of diffCommands) {
    try {
      const diffOutput = execSync(cmd, { cwd: rootDir, encoding: 'utf8', stdio: ['pipe', 'pipe', 'ignore'] });
      for (const line of diffOutput.split('\n')) {
        const file = line.trim();
        if (file) modified.add(file);
      }
      break;
    } catch {
      // Try next diff fallback
    }
  }

  return Array.from(modified);
}

export function detectAffectedApps(changedFiles, deployTargets) {
  const affected = new Set();
  const ignored = deployTargets.ignoredPaths || [];

  for (const file of changedFiles) {
    const isIgnored = ignored.some(pattern => matchPathPattern(file, pattern));
    if (isIgnored) continue;

    for (const [appKey, appDef] of Object.entries(deployTargets.apps)) {
      if (appDef.active === false) continue;
      const matches = (appDef.paths || []).some(pattern => matchPathPattern(file, pattern));
      if (matches) {
        affected.add(appKey);
      }
    }
  }

  return Array.from(affected);
}

export function generateSlug() {
  const adjectives = ['swift', 'bright', 'quiet', 'brave', 'serene', 'vivid', 'steady', 'humble', 'noble'];
  const nouns = ['stream', 'harbor', 'forest', 'haven', 'beacon', 'summit', 'breeze', 'stride', 'anchor'];
  const adj = adjectives[Math.floor(Math.random() * adjectives.length)];
  const noun = nouns[Math.floor(Math.random() * nouns.length)];
  const num = Math.floor(100 + Math.random() * 900);
  return `${adj}-${noun}-${num}`;
}

export function createChangesetFile({ appBumps, summary, slug }) {
  const changesetDir = path.join(rootDir, '.changeset');
  if (!fs.existsSync(changesetDir)) {
    fs.mkdirSync(changesetDir, { recursive: true });
  }

  const filename = `${slug || generateSlug()}.md`;
  const filePath = path.join(changesetDir, filename);

  const frontmatterLines = ['---'];
  for (const [appKey, bumpType] of Object.entries(appBumps)) {
    frontmatterLines.push(`"${appKey}": ${bumpType}`);
  }
  frontmatterLines.push('---', '', summary.trim(), '');

  fs.writeFileSync(filePath, frontmatterLines.join('\n'), 'utf8');
  return { filename, filePath };
}

async function runCli() {
  const args = process.argv.slice(2);
  const deployTargets = loadDeployTargets();

  let appBumps = {};
  let summary = '';
  let slug = '';

  for (let i = 0; i < args.length; i++) {
    if (args[i] === '--apps' && args[i + 1]) {
      const pairs = args[i + 1].split(',');
      for (const pair of pairs) {
        const [app, bump] = pair.split(':');
        appBumps[app.trim()] = (bump || 'patch').trim();
      }
      i++;
    } else if (args[i] === '--summary' && args[i + 1]) {
      summary = args[i + 1];
      i++;
    } else if (args[i] === '--slug' && args[i + 1]) {
      slug = args[i + 1];
      i++;
    }
  }

  if (Object.keys(appBumps).length > 0 && summary) {
    const result = createChangesetFile({ appBumps, summary, slug });
    console.log(`\n✅ Changeset created: .changeset/${result.filename}`);
    console.log(`   Declared deployments:`, appBumps);
    return;
  }

  console.log('====================================================');
  console.log('  Bona Loko — Changeset Generator');
  console.log('====================================================\n');

  const changedFiles = getModifiedFiles();
  const detectedApps = detectAffectedApps(changedFiles, deployTargets);

  console.log(`📁 Files modified: ${changedFiles.length}`);
  if (detectedApps.length > 0) {
    console.log(`🎯 Detected modified applications: ${detectedApps.join(', ')}\n`);
  } else {
    console.log(`ℹ️ No active application files detected as modified.\n`);
  }

  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
  });

  try {
    const activeApps = Object.keys(deployTargets.apps).filter(k => deployTargets.apps[k].active !== false);

    console.log('Available applications:');
    activeApps.forEach((app, idx) => {
      const isDetected = detectedApps.includes(app);
      console.log(`  [${idx + 1}] ${app} ${isDetected ? '(detected changes)' : ''}`);
    });

    const defaultSelection = detectedApps.length > 0 ? detectedApps.join(',') : activeApps[0];
    const appAnswer = await rl.question(
      `\nSelect apps to deploy (comma-separated names, default: "${defaultSelection}"): `
    );
    const selectedAppList = (appAnswer.trim() || defaultSelection)
      .split(',')
      .map(s => s.trim())
      .filter(Boolean);

    for (const app of selectedAppList) {
      if (!deployTargets.apps[app]) {
        console.warn(`⚠️ Warning: "${app}" is not defined in deploy-targets.json`);
      }
      const bumpAnswer = await rl.question(
        `Select release bump for "${app}" [patch / minor / major] (default: patch): `
      );
      const bump = bumpAnswer.trim().toLowerCase() || 'patch';
      appBumps[app] = ['patch', 'minor', 'major'].includes(bump) ? bump : 'patch';
    }

    const summaryAnswer = await rl.question('\nEnter summary of changes for release notes: ');
    summary = summaryAnswer.trim() || 'Internal improvements and updates.';

    const result = createChangesetFile({ appBumps, summary });
    console.log(`\n🎉 Changeset successfully generated: .changeset/${result.filename}`);
    console.log('   Remember to commit this changeset with your PR branch:');
    console.log(`   git add .changeset/${result.filename}`);
    console.log('   git commit -m "chore: add release changeset"\n');
  } finally {
    rl.close();
  }
}

if (process.argv[1] && path.resolve(process.argv[1]) === path.resolve(__filename)) {
  runCli().catch(err => {
    console.error(`\n❌ Error: ${err.message}`);
    process.exit(1);
  });
}
