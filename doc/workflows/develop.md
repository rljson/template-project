<!--
@license
Copyright (c) 2025 Rljson

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Ticket workflow

- [Checkout main](#checkout-main)
- [Set pull request title](#set-pull-request-title)
- [Create a feature branch](#create-a-feature-branch)
- [Update dependencies](#update-dependencies)
- [Develop \& debug](#develop--debug)
- [Commit](#commit)
- [Increase version](#increase-version)
- [Run tests and build](#run-tests-and-build)
- [Rebase main](#rebase-main)
- [Create a pull request](#create-a-pull-request)
- [Code review](#code-review)
- [Checkout main and delete feature branch](#checkout-main-and-delete-feature-branch)
- [Publish to NPM](#publish-to-npm)

## Checkout main

```bash
git checkout main
git fetch
git pull
```

## Set pull request title

Replace `Improve delete-feature-branch.js` here and below
by your new pull request title.

## Create a feature branch

```bash
node scripts/create-branch.js "Improve delete-feature-branch.js"
```

## Update dependencies

```bash
pnpm update --latest
```

## Develop & debug

- [Debug & debug with Vscode](./debug-with-vscode.md)
- [Update Goldens](./update-goldens.md)
- [Rename classes](./rename-classes.md)
- [Super hero tricks](./super-hero.md)

## Commit

Use Vscode or another git client to commit your changes

If you have only one change, run

In Vscode, press

```bash
git add .
git commit -am"Improve delete-feature-branch.js"
```

## Increase version

```bash
pnpm version patch --no-git-tag-version
git commit -am"Increase version"
```

## Run tests and build

```bash
npm run build
```

## Rebase main

```bash
git rebase main
```

## Create a pull request

In Vscode, press

```bash
node scripts/push-branch.js
gh pr create --base main --title "Improve delete-feature-branch.js" --body " "
```

## Code review

You need a code review? Read [code-review.md](./code-review.md).

If you don't require a code review, auto merge the branch

```bash
gh pr merge --auto --squash
node scripts/wait-for-pr.js
```

## Checkout main and delete feature branch

```bash
node scripts/delete-feature-branch.js
```

## Publish to NPM

```bash
node scripts/publish-to-npm.js
```
