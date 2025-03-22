/*
 * @license
 * Copyright (c) 2025 Rljson
 *
 * Use of this source code is governed by terms that can be
 * found in the LICENSE file in the root of this package.
 */

// publish-and-tag.js
import { runCommand } from './functions/run-command';

(async () => {
  try {
    console.log('📦 Publishing package...');
    runCommand('npm publish --access public');
    console.log('✅ Publish successful. Adding version tag...');
    runCommand('node scripts/add-version-tag.js');
    console.log('🏷️ Version tag added.');
  } catch (e) {
    console.error('❌ Operation failed:', e.error?.message || e);
    process.exit(1);
  }
})();
