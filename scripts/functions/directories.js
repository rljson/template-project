/*
 * @license
 * Copyright (c) 2025 Rljson
 *
 * Use of this source code is governed by terms that can be
 * found in the LICENSE file in the root of this package.
 */

// Get the name of this file
import { dirname, join } from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

export const workSpaceDir = join(__dirname, '..', '..');
export const distDir = join(workSpaceDir, 'dist');
export const srcDir = join(workSpaceDir, 'src');
export const testDir = join(workSpaceDir, 'test');
