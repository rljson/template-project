/*
 * @license
 * Copyright (c) 2025 Rljson
 *
 * Use of this source code is governed by terms that can be
 * found in the LICENSE file in the root of this package.
 */

// checkRepo.js
import { execSync } from 'child_process';

export function isCleanRepo() {
  try {
    // Aktuellen Branch ermitteln
    const branch = execSync('git rev-parse --abbrev-ref HEAD')
      .toString()
      .trim();
    if (branch !== 'main') {
      return false;
    }

    // Git-Fetch ausführen (still)
    execSync('git fetch', { stdio: 'ignore' });

    // Prüfen, ob Arbeitsverzeichnis sauber ist
    const status = execSync('git status --porcelain').toString().trim();
    if (status.length > 0) {
      return false;
    }

    // Prüfen, ob main auf dem neuesten Stand mit origin/main ist
    const revList = execSync(
      'git rev-list --left-right --count origin/main...main',
    )
      .toString()
      .trim();

    const [behind, ahead] = revList.split('\t').map(Number);
    return behind === 0 && ahead === 0;
  } catch (err) {
    console.error('Git error:', err.message);
    return false;
  }
}

console.log(isCleanRepo() ? '✅ clean' : '❌ dirty');
