<!--
@license
Copyright (c) 2025 Rljson

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Contributors Guide

- [Preparation](#preparation)
- [Development](#development)
  - [Define branch and PR name](#define-branch-and-pr-name)
  - [Checkout main](#checkout-main)
  - [Create a feature branch](#create-a-feature-branch)
  - [Develop and debug with Vscode](#develop-and-debug-with-vscode)
  - [Update goldens](#update-goldens)
  - [Commit](#commit)
  - [Update dependencies](#update-dependencies)
  - [Increase version](#increase-version)
  - [Run tests and build](#run-tests-and-build)
  - [Create a pull request](#create-a-pull-request)
  - [Delete feature branch](#delete-feature-branch)
  - [Publish to NPM](#publish-to-npm)
- [Workflows](#workflows)
  - [Rename classes](#rename-classes)
  - [Create a new repo](#create-a-new-repo)
  - [Handle issues](#handle-issues)

## Preparation

Please checkout [prepare.md](doc/workflows/prepare.md)

## Development

### Define branch and PR name

Replace `rename-template-into-template-project` by the name of your new branch

Replace `Rename template into template-project` by your new pull request title

### Checkout main

```bash
git checkout main
git fetch
git pull
```

### Create a feature branch

```bash
git checkout -b rename-template-into-template-project
```

### Develop and debug with Vscode

In Vscode: At the `left side bar` click on the `Test tube` icon to open the `Test explorer`

At the `top`, click on the `refresh` icon to show update the tests

Open a test file (`*.spec.ts`)

Set a breakpoint

Press `alt` and click on the play button left beside the test

Execution should stop at the breakpoint

### Update goldens

In various tests test against golden files. To update these, execute:

```bash
pnpm updateGoldens
```

In vscode, click the `source control` icon at the left side bar

Click on changed golden files

Review the changes

On unwanted changes, fix the reason and update goldens again

### Commit

If you only have one thing changed, execute

```bash
git add .
git commit -m "Fix issues in README.contributors.md"
```

### Update dependencies

```bash
pnpm update --latest
git commit -am"Update dependencies"
```

### Increase version

```bash
pnpm version patch --no-git-tag-version
git commit -am"Increase version"
```

### Run tests and build

```bash
npm run build
```

### Create a pull request

```bash
git push -u origin rename-template-into-template-project
gh pr create --base main --title "Fix issues in README.contributors.md" --body " "
gh pr merge --auto --squash
node ./scripts/wait-for-pr.js
```

### Delete feature branch

```bash
git fetch
git checkout main
git reset --soft origin/main
git stash -m"PR Aftermath"
git pull
git branch -d rename-template-into-template-project
```

### Publish to NPM

```bash
npm publish --access public
node scripts/add-version-tag.js
```

<!-- ........................................................................-->

## Workflows

Read [README.architecture.md](./README.architecture.md) to get an overview
of the package's architecture.

### Rename classes

Replace `ClassA` by `ClassB` in the following script and run it:

```bash
node ./scripts/rename-class.js ClassA ClassB
```

### Create a new repo

To create a new repo checkout [create-new-repo.md](doc/workflows/create-new-repo.md)

### Handle issues

#### Checkout README.trouble.md

Checkout [./README.trouble.md](./README.trouble.md)

#### File and issue

Visit <https://github.com/rljson/template-project/issues>

Check if there is already an issue for your problem.

If no, report the issue.
