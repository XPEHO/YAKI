# YAKI

Working localization delcaration app

## Structure

**yaki_admin**

Contains the Web administration UI

**yaki_backend**

Contains the backend server

**yaki_database**

Contains the database scripts

**yaki_mobile**

Contains the mobile app

## Pull request CI

**Git checks**

Each pull request will trigger several checks like:

* branch name
* commit message
* up to date branch

> See `.github/workflows/git_checks.yaml` workflow file

**Labels**

A label will be automatically added to pull requests regarding the branch name in order to prepare the auto generated changelog

> See `.github/workflows/labels.yaml` workflow file

## Automatic release changelog

The `.github/release.yml` file contains the configuration for automatic changelog generation

For more information please visit [Automatically generated release notes](https://docs.github.com/en/repositories/releasing-projects-on-github/automatically-generated-release-notes)