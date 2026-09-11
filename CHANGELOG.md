# Changelog

## Unreleased

### Added

- `tsconfig.json` extends the new `tsconfig.workspace.json`, whose `paths` gg fills in a ticket with the sources of the sibling repos; `rootDir` is `../..` so those files may join the program. vitest resolves them via `resolve.tsconfigPaths`, so a test steps into the TypeScript of a sibling and breakpoints there hit.
- The build emits source maps, and the launch configuration »Debug current vitest file« debugs the open spec.

## [0.0.1]

Initial commit.
