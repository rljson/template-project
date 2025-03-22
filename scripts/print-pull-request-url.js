/*
 * @license
 * Copyright (c) 2025 Rljson
 *
 * Use of this source code is governed by terms that can be
 * found in the LICENSE file in the root of this package.
 */

import { execSync } from 'child_process';

import { blue, yellow } from './functions/colors.js';

function getPullRequestUrl() {
  try {
    const json = execSync('gh pr view --json url', {
      encoding: 'utf-8',
    }).trim();

    const parsed = JSON.parse(json);
    const url = parsed.url;
    console.log(blue(url));
  } catch (error) {
    console.error(yellow('No PR available'));
    process.exit(1);
  }
}

function main() {
  getPullRequestUrl();
}

main();
