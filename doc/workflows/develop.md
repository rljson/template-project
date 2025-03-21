<!--
@license
Copyright (c) 2025 Rljson

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Ticket workflow

- [Checkout main](#checkout-main)
- [Define branch and PR name](#define-branch-and-pr-name)
- [Create a feature branch](#create-a-feature-branch)
- [Update dependencies](#update-dependencies)
- [Develop and debug with Vscode](#develop-and-debug-with-vscode)
- [Update goldens](#update-goldens)
- [Commit](#commit)
- [Increase version](#increase-version)
- [Run tests and build](#run-tests-and-build)
- [Rebase main](#rebase-main)
- [Create a pull request](#create-a-pull-request)
- [Delete feature branch](#delete-feature-branch)
- [Publish to NPM](#publish-to-npm)

## Checkout main

```bash
git checkout main
git fetch
git pull
```

## Define branch and PR name

In the _whole document_, replace the following things:

- `setup-github-to-require-code-reviews` by the name of your new branch
- `Setup GitHub to require code reviews` by your new pull request title

## Create a feature branch

```bash
git checkout -b setup-github-to-require-code-reviews
```

## Update dependencies

```bash
pnpm update --latest
```

## Develop and debug with Vscode

In Vscode: At the `left side bar` click on the `Test tube` icon to open the `Test explorer`

At the `top`, click on the `refresh` icon to show update the tests

Open a test file (`*.spec.ts`)

Set a breakpoint

Press `alt` and click on the play button left beside the test

Execution should stop at the breakpoint

## Update goldens

In various tests test against golden files. To update these, execute:

```bash
pnpm updateGoldens
```

In vscode, click the `source control` icon at the left side bar

Click on changed golden files

Review the changes

On unwanted changes, fix the reason and update goldens again

## Commit

Use Vscode or another git client to commit your changes

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

```bash
git push -u origin setup-github-to-require-code-reviews
gh pr create --base main --title "Setup GitHub to require code reviews" --body " "
gh pr merge --auto --squash
node ./scripts/wait-for-pr.js
```

## Delete feature branch

```bash
git fetch
git checkout main
git reset --soft origin/main
git stash -m"PR Aftermath"
git pull
git branch -d setup-github-to-require-code-reviews
```

## Publish to NPM

```bash
npm publish --access public
node scripts/add-version-tag.js
```
