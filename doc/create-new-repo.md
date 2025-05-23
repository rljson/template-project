<!--
@license
Copyright (c) 2025 Rljson

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Create a new Rljson repository

## Content <!-- omit in toc -->

- [Replace in this doc](#replace-in-this-doc)
- [Create repo](#create-repo)
- [Setup branch rules](#setup-branch-rules)
- [Require deleting branches after merge](#require-deleting-branches-after-merge)
- [Checkout and open the new project](#checkout-and-open-the-new-project)
- [Rename template-project into my-new-repo](#rename-template-project-into-my-new-repo)
  - [Call rename script](#call-rename-script)
- [Edit package.json](#edit-packagejson)
- [Commit the initial state](#commit-the-initial-state)
  - [Create and complete pull request](#create-and-complete-pull-request)
  - [Delete feature branch](#delete-feature-branch)

## Replace in this doc

In the _whole_ file:

Replace `my-new-repo` by the name of your new repo

Replace `Rljson template-project description` by a short project description

## Create repo

Open <https://github.com/rljson>

Select `Repositories`

Click `New repository`

Below `Repository template` click on the drop down `No template`

Select the template repository `@rljson/template-project`

Enter a `my-new-repo` as `name`

Into the `Title` field, paste `Rljson template-project description`

Create the repo as used

## Setup branch rules

Open <https://github.com/rljson/my-new-repo>

Click `Settings`

Click `Branches`

Locate `Branch Protection Rules`

Click `Add branch ruleset`

As `Ruleset Name` enter `Default`

Set `Enforcement status` to `Active`

Locate `Branch targeting criteria`

Click `Add target`

Select `Include default branch`

Check the following settings:

- [x] `Restrict deletions`
- [x] `Require linear history`
- [x] `Require a pull request before merging`
  - You want to require a code review before merging?
    - No
      - Keep the default settings
        - Set `Required Approvals` to 0
        - Don't check any off the boxes
    - Yes
      - Click on the dropdown below `Required approvals`
        - Select `1` for `Required Approvals`
        - Check the following boxes:
          - [ ] `Dismiss stale pull request approvals when new commits are pushed`
          - [ ] `Require review from code owners`
          - [x] `Require approval of the most recent reviewable push`
          - [x] `Require conversation resolution before merging`
  - Click on `Allowed merge methods:`
    - Only select `Squash`
- [x] `Require status checks to pass`
  - [x] `Require branches to be up to date before merging`
  - Click `Add checks`
  - Enter `Build` into the search field
  - Select `Build and Test` GitHub Actions
- [x] `Block force pushes`

Click `Create`

When asked, Authenticate

## Require deleting branches after merge

Open <https://github.com/rljson/my-new-repo>

Click `Settings`

Scroll down to `Pull Requests`

Apply the following settings:

- [ ] `Allow merge commits`
- [x] `Allow squash merging`
- [ ] `Allow rebase merging`
- [x] `Always suggest updating pull request branches`
- [x] `Allow auto-merge`
- [x] `Automatically delete head branches`

## Checkout and open the new project

Checkout the project

```bash
git clone git@github.com:rljson/my-new-repo.git
cd my-new-repo
pnpm install
pnpm build
```

Open project with vscode

```bash
code .
```

Prepare a new branch and pull request

```bash
git checkout -b rename-classes
```

## Rename template-project into my-new-repo

### Call rename script

```bash
node scripts/rename-class.js template-project my-new-repo
```

## Edit package.json

Open `package.json` and add the following changes:

Reset version to `0.0.1`

Set description to `Rljson template-project description`

## Commit the initial state

```bash
git add .
git commit -am "Rename template-project into my-new-repo"
```

### Create and complete pull request

```bash
node scripts/push-branch.js
gh pr create --base main --title "Rename template-project into my-new-repo" --body " "
gh pr merge --auto --squash
node ./scripts/wait-for-pr.js
```

### Delete feature branch

```bash
node scripts/delete-feature-branch.js
```
