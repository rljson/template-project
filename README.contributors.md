<!--
@license
Copyright (c) 2025 Rljson

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Contributors Guide

- [Install](#install)
  - [Windows: Install WSL](#windows-install-wsl)
  - [Windows: Install node on VWSL](#windows-install-node-on-vwsl)
  - [Install Vscode](#install-vscode)
  - [Start Vscode](#start-vscode)
  - [Windows: Install Vscode wsl extension](#windows-install-vscode-wsl-extension)
  - [Windows: Connect WSL](#windows-connect-wsl)
  - [Create a ~/dev folder](#create-a-dev-folder)
  - [Install Vscode extensions](#install-vscode-extensions)
  - [Windows: Uninstall existing node](#windows-uninstall-existing-node)
  - [Windows: Install NVM-Windows](#windows-install-nvm-windows)
  - [Windows: Install node via nvw-windows](#windows-install-node-via-nvw-windows)
  - [Install pnpm](#install-pnpm)
  - [Install dependencies](#install-dependencies)
  - [Uninstall Jest and Jasmine](#uninstall-jest-and-jasmine)
  - [Install GitHub CLI](#install-github-cli)
  - [Login GitHub Cli](#login-github-cli)
  - [Checkout rljson/template](#checkout-rljsontemplate)
  - [Open project with Vscode](#open-project-with-vscode)
- [Develop](#develop)
  - [Read architecture doc](#read-architecture-doc)
  - [Debug](#debug)
  - [Update goldens](#update-goldens)
  - [Test and Build](#test-and-build)
  - [Rename classes](#rename-classes)
- [Workflow](#workflow)
  - [Set a PR title](#set-a-pr-title)
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
- [Troubleshooting](#troubleshooting)
  - [Checkout README.trouble.md](#checkout-readmetroublemd)
  - [File issues on GitHub](#file-issues-on-github)

<!-- ........................................................................-->

## Install

### Windows: Install WSL

To ensure the same user experience accross all platforms (windows, linux, mac)
we are using the Windows Subsystem for Linux WSL.

Press `Windows`

Type `cmd`

Click `Als Administrator ausführen`

```bash
wsl --install Ubuntu
```

Restart computer

Start wsl

```bash
wsl
```

Enter username

Enter password

Wait until console is available

Optional: Move home directory to d:

```bash
sudo mv /home /mnt/d/home
ln -s /mnt/d/home /home
```

Install zsh

```bash
sudo apt update && sudo apt install zsh -y
chsh -s $(which zsh)
```

Start zsh the first time

```bash
zsh
```

When asked, enter `2` to create a pre-filled `.zshrc`

### Windows: Install node on VWSL

Press `Windows`

Type `Ubuntu`

Click `Ubuntu`

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
```

Restart Ubuntu

```bash
 nvm install --lts
```

### Install Vscode

Visit <https://code.visualstudio.com/download>

Download and install Vscode

### Start Vscode

Press `Windows`

Type `ubuntu`

Press `Enter`

Start vscode

```bash
code
```

### Windows: Install Vscode wsl extension

Press `windows`

Type `vscode`

Press `enter`

Vscode is opened

Open `extensions`

Click into the `top search field`

Type `wsl`

Install the extension

### Windows: Connect WSL

In Vscode, press `Cmd+Shift+P`

Start typing `connect to wsl`

Select `WSL: connect to wsl`

Code will connect to the WSL

### Create a ~/dev folder

```bash
mkdir ~/dev
```

### Install Vscode extensions

Open `template` with vscode (see before)

Press `Cmd+Shift+P`.

Type `Extensions: Show Recommended Extensions` and press `Enter`.

The recommended extensions will be shown.

Make sure, all recommended extensions are shown.

### Windows: Uninstall existing node

Uninstall existing Node.js because we will use NVM to manage Node.js versions

#### Clean cache

[Microsoft](https://learn.microsoft.com/de-de/windows/dev-environment/javascript/nodejs-on-windows#install-nvm-windows-nodejs-and-npm)

```bash
npm cache clean --force
```

#### Run uninstaller

Press `Windows`

Type `uninstall Node.js`

Klick `Uninstall Node.js`

Follow instructions

#### Remove remaining node.js folders

[Remove remaining node.js folders](https://stackoverflow.com/questions/20711240/how-to-completely-remove-node-js-from-windows)

#### Remove node path from PATH variable

Remove node.js from PATH variable:

Press `Windows`

Type `environment`

Click `Systemumgebungsvariablen bearbeiten`

In the `upper box`, select `PATH`

Click `Bearbeiten`

Search for Node.js path

When existing, remove the entry.

Close the dialog

### Windows: Install NVM-Windows

[Source](https://github.com/coreybutler/nvm-windows#installation--upgrades)

Open <https://github.com/coreybutler/nvm-windows/releases>

Download `nvm-setup.exe` ()

Execute `nvm-setup.exe`

Follow instructions

### Windows: Install node via nvw-windows

Press `Windows`

Type `cmd` and pres `enter`

```bash
nvm install lts
nvm use lts
```

### Install pnpm

#### Windows

Press `Windows`

Type `cmd`

Click `Als Administrator ausführen`

```bash
npm install --global corepack@latest
corepack enable pnpm
corepack use pnpm@latest-10
```

#### Mac/Linux

```bash
sudo corepack enable pnpm
```

### Install dependencies

```bash
pnpm install
```

### Uninstall Jest and Jasmine

Jest or Jasmine extensions conflict with the `Vitest` extension used for this
project.

Uninstall them, if you have installed them.

### Install GitHub CLI

| Windows                         | Mac/Linux         |
| :------------------------------ | :---------------- |
| Visit <https://cli.github.com/> | `brew install gh` |
| Download and install            |                   |

Restart vscode when opened

### Login GitHub Cli

Login

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

### Checkout rljson/template

```bash
cd ~/dev/rljson
git clone https://github.com/rljson/template.git
```

### Open project with Vscode

```bash
cd ~/dev/rljson/template
code .
```

<!-- ........................................................................-->

## Develop

### Read architecture doc

Read [README.architecture.md](./README.architecture.md) to get an overview
of the package's architecture.

### Debug

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

## Workflow

### Set a PR title

```bash
export PR_TITLE="PR Title"
```

### Checkout main

```bash
git checkout main
git fetch
git pull
```

### Create a feature branch

```bash
export BRANCH=`echo "$PR_TITLE" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9_]/_/g'`
git checkout -b $BRANCH
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

## Troubleshooting

### Checkout README.trouble.md

Checkout [./README.trouble.md](./README.trouble.md)

### File issues on GitHub

Visit <https://github.com/rljson/template/issues>

Check if there is already an issue for your problem.

If no, report the issue.
