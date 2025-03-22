/*
 * @license
 * Copyright (c) 2025 Rljson
 *
 * Use of this source code is governed by terms that can be
 * found in the LICENSE file in the root of this package.
 */

import { execSync } from 'child_process';
import { gray, green, red } from './functions/colors.js';
import { currentBranch } from './functions/current-branch.js';
import { isMainUpToDate } from './functions/is-main-up-to-date.js';

const createVersionTag = (version) => {
  try {
    execSync(`git tag v${version}`);
    execSync(`git push origin v${version}`);
    console.log(green(`Tag v${version} created and pushed successfully.`));
  } catch (error) {
    console.error(
      red('Error creating or pushing tag\n'),
      gray(error.message.trim()),
    );
  }
};

const main = async () => {
  const branch = currentBranch();
  if (branch !== 'main') {
    console.error(red('Error: You must be on the main branch.'));
    process.exit(1);
  }

  if (!isMainUpToDate()) {
    console.error(
      red('Error: main branch is not up to date with origin/main.'),
    );
    process.exit(1);
  }

  const version = await getVersion();
  createVersionTag(version);
};

main().catch(console.error);
