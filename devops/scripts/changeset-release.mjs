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

export function bumpSemver(currentVersion, bumpType) {
  const parts = currentVersion.split('.').map(n => parseInt(n, 10));
  if (parts.length !== 3 || parts.some(isNaN)) {
    throw new Error(`Invalid semver version: "${currentVersion}"`);
  }
  let [major, minor, patch] = parts;

  switch (bumpType.toLowerCase()) {
    case 'major':
      major += 1;
      minor = 0;
      patch = 0;
      break;
    case 'minor':
      minor += 1;
      patch = 0;
      break;
    case 'patch':
    default:
      patch += 1;
      break;
  }

  return `${major}.${minor}.${patch}`;
}

export function resolveHighestBump(currentBump, newBump) {
  const priority = { patch: 1, minor: 2, major: 3 };
  const curP = priority[currentBump] || 0;
  const newP = priority[newBump] || 1;
  return newP > curP ? newBump : currentBump;
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

export function collectPendingChangesets(changesetDir = path.join(rootDir, '.changeset')) {
  if (!fs.existsSync(changesetDir)) {
    return { appBumps: {}, changesetFiles: [] };
  }

  const appBumps = {};
  const changesetFiles = [];
  const entries = fs.readdirSync(changesetDir);

  for (const entry of entries) {
    if (entry.endsWith('.md') && entry !== 'README.md') {
      const fullPath = path.join(changesetDir, entry);
      changesetFiles.push(fullPath);
      const content = fs.readFileSync(fullPath, 'utf8');
      const { apps } = parseChangesetContent(content);

      for (const [appKey, bumpType] of Object.entries(apps)) {
        appBumps[appKey] = resolveHighestBump(appBumps[appKey], bumpType);
      }
    }
  }

  return { appBumps, changesetFiles };
}

export function executeRelease({ dryRun = false, pushTags = true } = {}) {
  const deployTargets = loadDeployTargets();
  const { appBumps, changesetFiles } = collectPendingChangesets();

  const releasedApps = [];
  const createdTags = [];

  console.log('====================================================');
  console.log('  Bona Loko — Release & Multi-Tagging');
  console.log('====================================================');

  if (changesetFiles.length === 0 || Object.keys(appBumps).length === 0) {
    console.log('ℹ️ No pending changesets found. Nothing to release.');
    return { releasedApps, createdTags };
  }

  console.log(`📄 Found ${changesetFiles.length} pending changeset(s).`);
  console.log(`🚀 Apps to release:`, appBumps);

  for (const [appKey, bumpType] of Object.entries(appBumps)) {
    const appDef = deployTargets.apps[appKey];
    if (!appDef) {
      console.warn(`⚠️ Warning: App "${appKey}" not recognized in deploy-targets.json. Skipping.`);
      continue;
    }

    let currentVersion = '1.0.0';
    let versionFilePath = null;

    if (appDef.versionFile) {
      versionFilePath = path.join(rootDir, appDef.versionFile);
      if (fs.existsSync(versionFilePath)) {
        const pkgJson = JSON.parse(fs.readFileSync(versionFilePath, 'utf8'));
        currentVersion = pkgJson.version || '1.0.0';
      }
    }

    const nextVersion = bumpSemver(currentVersion, bumpType);
    const tagName = `${appDef.tagPrefix || appKey}/v${nextVersion}`;

    console.log(`\n📦 [${appKey}] ${currentVersion} -> ${nextVersion} (${bumpType})`);
    console.log(`   Tag: ${tagName}`);

    if (!dryRun) {
      // 1. Update version file
      if (versionFilePath && fs.existsSync(versionFilePath)) {
        const pkgJson = JSON.parse(fs.readFileSync(versionFilePath, 'utf8'));
        pkgJson.version = nextVersion;
        fs.writeFileSync(versionFilePath, JSON.stringify(pkgJson, null, 2) + '\n', 'utf8');
        console.log(`   Updated version in ${appDef.versionFile}`);
      }

      // 2. Create git tag on current commit
      try {
        execSync(`git tag -a "${tagName}" -m "Release ${tagName}"`, { cwd: rootDir, stdio: 'inherit' });
        createdTags.push(tagName);
      } catch (err) {
        console.error(`   ❌ Failed to create tag ${tagName}: ${err.message}`);
      }
    } else {
      createdTags.push(tagName);
    }

    releasedApps.push({
      app: appKey,
      currentVersion,
      nextVersion,
      tag: tagName,
      deployTarget: appDef.deployTarget,
      cloudflareProject: appDef.cloudflareProject
    });
  }

  // Push created tags simultaneously
  if (!dryRun && pushTags && createdTags.length > 0) {
    console.log(`\n🚀 Multi-tagging push: Pushing ${createdTags.length} tag(s) to remote...`);
    try {
      execSync(`git push origin ${createdTags.map(t => `"${t}"`).join(' ')}`, { cwd: rootDir, stdio: 'inherit' });
      console.log('✅ Successfully pushed all release tags to remote.');
    } catch (err) {
      console.error(`❌ Failed to push tags: ${err.message}`);
    }
  }

  // Clean consumed changesets
  if (!dryRun) {
    for (const filePath of changesetFiles) {
      fs.unlinkSync(filePath);
    }
    console.log(`🧹 Cleaned up ${changesetFiles.length} consumed changeset(s).`);
  }

  // Export to GitHub Actions step outputs if present
  if (process.env.GITHUB_OUTPUT) {
    const isWebAppReleased = releasedApps.some(r => r.app === 'web-app');
    const webAppRelease = releasedApps.find(r => r.app === 'web-app');

    fs.appendFileSync(process.env.GITHUB_OUTPUT, `deploy_web_app=${isWebAppReleased}\n`);
    fs.appendFileSync(process.env.GITHUB_OUTPUT, `released_apps=${releasedApps.map(r => r.app).join(',')}\n`);
    if (webAppRelease) {
      fs.appendFileSync(process.env.GITHUB_OUTPUT, `web_app_version=${webAppRelease.nextVersion}\n`);
      fs.appendFileSync(process.env.GITHUB_OUTPUT, `web_app_tag=${webAppRelease.tag}\n`);
    }
  }

  return { releasedApps, createdTags };
}

async function runCli() {
  const args = process.argv.slice(2);
  const dryRun = args.includes('--dry-run');
  const noPush = args.includes('--no-push');

  executeRelease({ dryRun, pushTags: !noPush });
}

if (process.argv[1] && path.resolve(process.argv[1]) === path.resolve(__filename)) {
  runCli().catch(err => {
    console.error(`\n❌ Error: ${err.message}`);
    process.exit(1);
  });
}
