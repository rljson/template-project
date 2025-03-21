<!--
@license
Copyright (c) 2025 Rljson

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Ticket workflow

- [Define branch and PR name](#define-branch-and-pr-name)
- [Checkout main](#checkout-main)
- [Create a feature branch](#create-a-feature-branch)
- [Update dependencies](#update-dependencies)
- [Develop and debug with Vscode](#develop-and-debug-with-vscode)
- [Update goldens](#update-goldens)
- [Commit](#commit)
- [Increase version](#increase-version)
- [Run tests and build](#run-tests-and-build)
- [Create a pull request](#create-a-pull-request)
- [Delete feature branch](#delete-feature-branch)
- [Publish to NPM](#publish-to-npm)

## Define branch and PR name

Replace `create-doc-workflow-ticket-workflow-md` by the name of your new branch

Replace `Create doc/workflows/ticket-workflow.md` by your new pull request title

## Checkout main

```bash
git checkout main
git fetch
git pull
```

## Create a feature branch

```bash
git checkout -b create-doc-workflow-ticket-workflow-md
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

## Create a pull request

```bash
git push -u origin create-doc-workflow-ticket-workflow-md
gh pr create --base main --title "Create doc/workflows/ticket-workflow.md" --body " "
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
git branch -d create-doc-workflow-ticket-workflow-md
```

## Publish to NPM

```bash
npm publish --access public
node scripts/add-version-tag.js
```
