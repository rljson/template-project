// @license
// Copyright (c) 2025 Rljson
//
// Use of this source code is governed by terms that can be
// found in the LICENSE file in the root of this package.

import { readFileSync, writeFileSync } from 'fs';
import { join } from 'path';
import { expect } from 'vitest';

/// If this is set to true, the golden files will be updated.
export const shouldUpdateGoldens = () => {
  return process.env['UPDATE_GOLDENS'] === 'true';
};

/**
 * Updates the golden file with the given content.
 * @param filexName - The golden file to compare with
 * @param expected - The expected golden content
 */
export const expectGolden = (fileName: string) => {
  return {
    toBe: (expected: string) => {
      const filePath = join(__dirname, '..', 'goldens', fileName);

      // Write golden file
      if (shouldUpdateGoldens()) {
        writeFileSync(filePath, expected);
      }

      // Check if golden file exists
      let needsGoldenUpdate: boolean = true;
      try {
        const golden = readFileSync(filePath, 'utf8');
        needsGoldenUpdate = golden !== expected;
      } catch {
        needsGoldenUpdate = true;
      }

      if (needsGoldenUpdate) {
        expect.fail(
          `Golden "${fileName}" has changed. Please run »pnpm updateGoldens« and check changes.`,
        );
      }
    },
  };
};
