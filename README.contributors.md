<!--
@license
Copyright (c) 2025 Rljson

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Contributors Guide

- [Install Tools](#install-tools)
  - [Node](#node)
  - [PNPM](#pnpm)
  - [GitHub CLI](#github-cli)
  - [Vscode](#vscode)
- [Get access To GitHb](#get-access-to-githb)
  - [Get an GitHub account](#get-an-github-account)
  - [Become a contributor](#become-a-contributor)
  - [Upload your SSH key](#upload-your-ssh-key)
  - [Login with GitHub CLI](#login-with-github-cli)
- [Open the code the first time](#open-the-code-the-first-time)
  - [Create a dev folder](#create-a-dev-folder)
  - [Clone code](#clone-code)
  - [Open template with Vscode](#open-template-with-vscode)
  - [Install recommended extensions](#install-recommended-extensions)
  - [Activate PNPM for the project](#activate-pnpm-for-the-project)
- [Develop your feature](#develop-your-feature)
  - [Replace in this doc](#replace-in-this-doc)
  - [Checkout main](#checkout-main)
  - [Create a feature branch](#create-a-feature-branch)
  - [Update dependencies](#update-dependencies)
  - [Debug and develop](#debug-and-develop)
  - [Commit](#commit)
  - [Increase version](#increase-version)
  - [Build](#build)
  - [Create a pull request](#create-a-pull-request)
  - [Wait until PR is merged](#wait-until-pr-is-merged)
  - [Delete feature branch](#delete-feature-branch)
  - [Publish to NPM](#publish-to-npm)
- [Use this helpers](#use-this-helpers)
  - [Read architecture doc](#read-architecture-doc)
  - [Debug with Vscode](#debug-with-vscode)
  - [Update goldens](#update-goldens)
  - [Test and Build](#test-and-build)
  - [Rename classes](#rename-classes)
- [Troubleshooting](#troubleshooting)
  - [Checkout README.trouble.md](#checkout-readmetroublemd)
  - [File issues on GitHub](#file-issues-on-github)

<!-- ........................................................................-->

## Install Tools

### Node

[Install Node on Windows](./doc/install/node-win.md)

[Install Node on Mac](./doc/install/node-mac.md)

### PNPM

```bash
npm install --global corepack@latest
corepack enable pnpm

```

### GitHub CLI

Windows: Visit <https://cli.github.com>

Mac

```bash
brew install gh
```

Restart Terminal when opened

### Vscode

Visit <https://code.visualstudio.com/download>

Download and install

## Get access To GitHb

### Get an GitHub account

If you have already an GitHub account, skip this step.

Visit <https://github.com/>

In the top right corner, click `Sign up`

Follow the instructions to get an account

### Become a contributor

Ask an Administrator of the <https://github.com/rljson> to perform the
following steps:

1. Visit <https://github.com/rljson>

2. In the top menu, click `People`

3. Click the green `Invite member` button

4. Enter the new user's GitHub email address.

5. And click `Invite`

6. Wait until the new user has accepted the invitation

7. Assign the right role (member, outside contributor etc) to the new user

### Upload your SSH key

#### Create an SSH key

If you already have created an SSH key, skip this step.

Visit <https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account>

In the Tab bar select either `Mac`, `Windows` or `Linux`

Follow the instructions

### Login with GitHub CLI

We have installed the GitHub CLI before

Now its time to login

```bash
gh auth login
```

Select the following answers:

- ? Where do you use GitHub? `GitHub.com`
- ? What is your preferred protocol for Git operations on this host? `SSH`
- ? Upload your SSH public key to your GitHub account? `C:\Users\...`
- ? Title for your SSH key: (GitHub CLI) `Dell Laptop`
- ? How would you like to authenticate GitHub CLI? `Login with a web browser`

Copy the shown one-time code, right beside `First copy your one-time code`

Press `Enter`

Brows opens

Paste the code copied before

Make sure `rljson` is selected

Click `Authorize GitHub`

## Open the code the first time

### Create a dev folder

The following documentation uses `~/dev` as main checkout folder.
Please replace this folder by your personal dev folder.

```bash
cd ~/
mkdir dev
cd dev
mkdir rljson
cd rljson
```

### Clone code

```bash
cd ~/dev/rljson
git clone https://github.com/rljson/template.git
```

### Open template with Vscode

```bash
code template
```

### Install recommended extensions

When opening this project the first time, you will be asked to install
recommended workspace extensions. Click on `install`.

If you do not see this step,

Press `Ctrl+Shift+P`.

Type `Extensions: Show Recommended Extensions` and press `Enter`.

The recommended extensions will be shown.

Make sure, all recommended extensions are installed.

### Activate PNPM for the project

```bash
corepack use pnpm
```

<!-- ........................................................................-->

## Develop your feature

### Replace in this doc

Replace `make_readme_ready_for_windows` by the name of your new branch

### Checkout main

```bash
git checkout main
git fetch
git pull
```

### Create a feature branch

```bash
git checkout -b make_readme_ready_for_windows
```

### Update dependencies

```bash
pnpm update --latest
git commit -am"Update dependencies"
```

### Debug and develop

Debug and develop

### Commit

If you only have one thing changed, execute

```bash
git add . && git commit -m "$PR_TITLE"
```

### Increase version

```bash
pnpm version patch --no-git-tag-version
git commit -am"Increase version"
```

### Build

```bash
npm run build
```

### Create a pull request

```bash
git push -u origin $BRANCH
gh pr create --base main --title "$PR_TITLE" --body ""
gh pr merge --auto --squash
```

### Wait until PR is merged

```bash
echo -e "\033[34m$(gh pr view --json url | jq -r '.url')\033[0m"
echo -e "\033[33mWait until PR is closed or merged ...\033[0m"

while true; do
  STATUS=$(gh pr view --json state | jq -r '.state')
  if [ "$STATUS" = "CLOSED" ] || [ "$STATUS" = "MERGED" ]; then
    echo -e "\033[32mPR has been merged or closed.\033[0m"
    break
  elif [ "$STATUS" = "FAILED" ]; then
    echo -e "\033[31mError: PR has failed.\033[0m"
    break
  fi
  sleep 2
done
```

### Delete feature branch

```bash
git fetch && git checkout main
git reset --soft origin/main
git stash -m"PR Aftermath"
git pull
git branch -d $BRANCH
```

### Publish to NPM

```bash
npm publish --access public
git tag $(npm pkg get version | tr -d '\\"')
```

<!-- ........................................................................-->

## Use this helpers

### Read architecture doc

Read [README.architecture.md](./README.architecture.md) to get an overview
of the package's architecture.

### Debug with Vscode

In Vscode: At the `left side bar` click on the `Test tube` icon to open the `Test explorer`.

At the `top`, click on the `refresh` icon to show update the tests.

Open a test file (`*.spec.ts`)

Set a breakpoint.

Press `alt` and click on the play button left beside the test.

Execution should stop at the breakpoint.

### Update goldens

In various tests we are creating golden files, that are reference files that
are compared against the files created in the tests.

```bash
pnpm updateGoldens
```

### Test and Build

```bash
pnpm test
pnpm build
```

### Rename classes

Replace `ClassA` by `ClassB` in the following script and run it:

```bash
node ./scripts/rename-class.js Template ClassB
```

<!-- ........................................................................-->

## Troubleshooting

### Checkout README.trouble.md

Checkout [./README.trouble.md](./README.trouble.md)

### File issues on GitHub

Visit <https://github.com/rljson/template/issues>

Check if there is already an issue for your problem.

If no, report the issue.
