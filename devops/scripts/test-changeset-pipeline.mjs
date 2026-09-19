#!/usr/bin/env node

import assert from 'node:assert/strict';
import { loadDeployTargets, matchPathPattern } from './changeset-create.mjs';
import {
  evaluateRequiredApps,
  parseChangesetContent,
  validateChangesetMatch
} from './changeset-validate.mjs';
import { bumpSemver, resolveHighestBump } from './changeset-release.mjs';

console.log('====================================================');
console.log('  Running Changeset & Deployment Pipeline Tests');
console.log('====================================================\n');

let passedTests = 0;
let totalTests = 0;

function test(name, fn) {
  totalTests++;
  try {
    fn();
    console.log(`✅ PASS: ${name}`);
    passedTests++;
  } catch (err) {
    console.error(`❌ FAIL: ${name}`);
    console.error(err);
  }
}

// -------------------------------------------------------------
// Test 1: Path Pattern Matching
// -------------------------------------------------------------
test('matchPathPattern matches directory globs correctly', () => {
  assert.equal(matchPathPattern('web-app/pages/index.vue', 'web-app/**'), true);
  assert.equal(matchPathPattern('web-app/nuxt.config.ts', 'web-app/**'), true);
  assert.equal(matchPathPattern('content/pt-br/artigo.md', 'content/**'), true);
  assert.equal(matchPathPattern('devops/scripts/test.mjs', 'devops/**'), true);
  assert.equal(matchPathPattern('specs/features/001/spec.md', 'specs/**'), true);
  assert.equal(matchPathPattern('README.md', 'README.md'), true);
});

// -------------------------------------------------------------
// Test 2: Changeset Frontmatter Parser
// -------------------------------------------------------------
test('parseChangesetContent extracts app name, bump type, and summary', () => {
  const content = `---
"web-app": patch
---

Fixed dimension layout styling.`;

  const parsed = parseChangesetContent(content);
  assert.deepEqual(parsed.apps, { 'web-app': 'patch' });
  assert.equal(parsed.summary, 'Fixed dimension layout styling.');
});

// -------------------------------------------------------------
// Test 3: SemVer Bumping Logic
// -------------------------------------------------------------
test('bumpSemver increments major, minor, and patch correctly', () => {
  assert.equal(bumpSemver('1.0.0', 'patch'), '1.0.1');
  assert.equal(bumpSemver('1.0.9', 'patch'), '1.0.10');
  assert.equal(bumpSemver('1.0.5', 'minor'), '1.1.0');
  assert.equal(bumpSemver('1.4.2', 'major'), '2.0.0');
  assert.equal(resolveHighestBump('patch', 'minor'), 'minor');
  assert.equal(resolveHighestBump('major', 'minor'), 'major');
});

// -------------------------------------------------------------
// Test 4: Path-Filtering to Required Apps (web-app and bundled content)
// -------------------------------------------------------------
test('evaluateRequiredApps maps touched web-app and content files, ignoring docs/devops', () => {
  const deployTargets = loadDeployTargets();

  // Scenario A: web-app code file changed -> requires web-app
  const filesA = ['web-app/pages/index.vue', 'README.md', 'devops/scripts/test.mjs'];
  assert.deepEqual(evaluateRequiredApps(filesA, deployTargets), ['web-app']);

  // Scenario B: content file changed -> requires web-app because articles are bundled into the build
  const filesB = ['content/pt-br/dimensoes/saude.md'];
  assert.deepEqual(evaluateRequiredApps(filesB, deployTargets), ['web-app']);

  // Scenario C: only ignored documentation, devops, and meta files changed
  const filesC = ['README.md', 'specs/features/001/spec.md', 'devops/deploy-targets.json', '.gitignore'];
  assert.deepEqual(evaluateRequiredApps(filesC, deployTargets), []);
});

// -------------------------------------------------------------
// Test 5: Exact Match Validator (Acceptance Criteria Scenarios)
// -------------------------------------------------------------
test('Acceptance Scenario 1: Exact match for web-app passes validation', () => {
  const result = validateChangesetMatch({
    requiredApps: ['web-app'],
    declaredApps: ['web-app']
  });
  assert.equal(result.isValid, true);
  assert.equal(result.missingApps.length, 0);
  assert.equal(result.extraApps.length, 0);
});

test('Acceptance Scenario 2: Missing web-app on app changes fails validation (too few)', () => {
  const result = validateChangesetMatch({
    requiredApps: ['web-app'],
    declaredApps: []
  });
  assert.equal(result.isValid, false);
  assert.deepEqual(result.missingApps, ['web-app']);
  assert.equal(result.extraApps.length, 0);
});

test('Acceptance Scenario 3: Documentation/specs only change with no changeset passes', () => {
  const result = validateChangesetMatch({
    requiredApps: [],
    declaredApps: []
  });
  assert.equal(result.isValid, true);
  assert.equal(result.missingApps.length, 0);
  assert.equal(result.extraApps.length, 0);
});

test('Acceptance Scenario 4: Documentation/specs change with unnecessary web-app changeset fails', () => {
  const result = validateChangesetMatch({
    requiredApps: [],
    declaredApps: ['web-app']
  });
  assert.equal(result.isValid, false);
  assert.deepEqual(result.extraApps, ['web-app']);
});

test('Acceptance Scenario 5: Content update without changeset fails validation', () => {
  const deployTargets = loadDeployTargets();
  const changedFiles = ['content/pt-br/dimensoes/saude.md'];
  const requiredApps = evaluateRequiredApps(changedFiles, deployTargets);

  const result = validateChangesetMatch({
    requiredApps,
    declaredApps: []
  });
  assert.equal(result.isValid, false);
  assert.deepEqual(result.missingApps, ['web-app']);
});

test('Acceptance Scenario 6: Content update with declared web-app changeset passes validation', () => {
  const deployTargets = loadDeployTargets();
  const changedFiles = ['content/pt-br/dimensoes/saude.md'];
  const requiredApps = evaluateRequiredApps(changedFiles, deployTargets);

  const result = validateChangesetMatch({
    requiredApps,
    declaredApps: ['web-app']
  });
  assert.equal(result.isValid, true);
  assert.equal(result.missingApps.length, 0);
});

// -------------------------------------------------------------
// Summary
// -------------------------------------------------------------
console.log('\n----------------------------------------------------');
console.log(`Test Results: ${passedTests}/${totalTests} passed`);
console.log('----------------------------------------------------\n');

if (passedTests !== totalTests) {
  process.exit(1);
}
