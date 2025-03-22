/*
 * @license
 * Copyright (c) 2025 Rljson
 *
 * Use of this source code is governed by terms that can be
 * found in the LICENSE file in the root of this package.
 */

import { execSync } from 'child_process';

// Color helpers
const red = (str) => `\x1b[31m${str}\x1b[0m`;
const gray = (str) => `\x1b[90m${str}\x1b[0m`;
const yellow = (str) => `\x1b[33m${str}\x1b[0m`;
const green = (str) => `\x1b[32m${str}\x1b[0m`;
const blue = (str) => `\x1b[34m${str}\x1b[0m`;

// Execute a shell command and return trimmed output
function runCommand(command) {
  return execSync(command, { encoding: 'utf-8' }).trim();
}

// Check for uncommitted changes
function hasUncommittedChanges() {
  const status = runCommand('git status --porcelain');
  return status.length > 0;
}

// Check for unpushed commits
function hasUnpushedCommits(branch) {
  try {
    // Check if upstream is set
    runCommand(`git rev-parse --abbrev-ref ${branch}@{u}`);
    const ahead = runCommand(`git rev-list --count ${branch}@{u}..${branch}`);
    return parseInt(ahead, 10) > 0;
  } catch {
    // No upstream branch set
    return true;
  }
}

try {
  const currentBranch = runCommand('git rev-parse --abbrev-ref HEAD');

  if (currentBranch === 'main') {
    console.log(yellow('Please call this script from a feature branch.'));
    process.exit(0);
  }

  // Abort if working directory is dirty
  if (hasUncommittedChanges()) {
    console.error(red('❌ You have uncommitted changes.'));
    console.error(
      yellow('Please commit or stash your changes before continuing.'),
    );
    process.exit(1);
  }

  // Abort if branch has unpushed commits
  if (hasUnpushedCommits(currentBranch)) {
    console.error(red('❌ You have unpushed commits.'));
    console.error(yellow('Please push your branch before continuing.'));
    process.exit(1);
  }

  console.log(
    gray(
      `Checking if branch '${currentBranch}' is fully merged into 'main'...`,
    ),
  );

  // Make sure we have the latest info
  runCommand('git fetch');

  // Switch to main branch
  runCommand('git checkout main');

  // Check if current branch is fully merged
  const mergedBranches = runCommand('git branch --merged main')
    .split('\n')
    .map((b) => b.replace('*', '').trim());

  const isMerged = mergedBranches.includes(currentBranch);

  if (isMerged) {
    runCommand(`git branch -d ${currentBranch}`);
    console.log(
      green(`✅ Branch '${currentBranch}' was merged and has been deleted.`),
    );
  } else {
    console.error(red(`❌ Branch '${currentBranch}' is not fully merged.`));

    const message = [
      yellow(`Please merge ${currentBranch} to main and try again.`),
    ];

    console.log(message.join(' '));

    // Switch back to the feature branch
    runCommand(`git checkout ${currentBranch}`);
  }
} catch (error) {
  console.error(red(`Error: ${error.message}`));
  process.exit(1);
}
