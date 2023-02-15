# Contributing to YAKI

This file contains all the rules to follow in order to add your contribution to YAKI project.

# Public contributions

We are pleased to accept public issues from our users. Please fill an issue using one of the following templates.

## Feature requests

Wants to ask for a new feature in the app ? Choose this template.

Tell us about the context and the issue to solve with this feature.

Share any imaginated solution

Add some additional infos like screens, schemas, etc...

## Bugs

Please be precise for any bug reporting.

We need as much information as possible in order to be able to reproduce and fix the potential bug.

What was the context when the issue occured ?

How can we try to reproduce it ? What are the steps ?

What is the expected behavior ?

What happenned instead ?

Add every additional info like, phone model, OS, phone orientation (landscape, portrait), frequency, penality etc...

# XPEHO Internal contributions

## Accepted contributors

XPEHO company members are the only ones able to make code changes.

## Contribution process

1. Fill an issue to explain the change to do

2. XPEHO team will make some triage

3. Issue is accepted or rejected

4. Accepted issues will be prioritized

5. XPEHO Dev team will plan issue modifications in future dev cycle

6. Modifications will be pushed on a dedicated branch

7. Once ready, a Pull request is opened for code review and CI checks

8. Checked modification will be merged to the main branch

## Git flow

We work with `single trunk based developpment`

More information at [https://trunkbaseddevelopment.com/](https://trunkbaseddevelopment.com/)

### Branch names

All branches must reach the following convention

```
<prefix>/<change_name>
```

**Example**

```
feat/authentication
```

**Accepted prefix list**

* feat
* feature
* fix
* hotfix
* docs
* style
* refactor
* chore

**Prefix list explaination**

__feat__

Branch containing small enhancement changes

__feature__

Branch containing multiple enhancement changes from multiple feat ones

__fix__

Branch containing only a bug fix

__hotfix__

Branch containing only a PROD hurry fix

__docs__

Branch containing only documentation changes

__style__

Branch containing only UI style changes

__refactor__

Branch containing breaking changes

__chore__

Branch containing tooling change like CI/CD, Issue templates, gitignore file etc...

### Commit convention

We respect the `Angular Js Commit message` convention 

Full documentation at [https://gist.github.com/stephenparish/9941e89d80e2bc58a153](https://gist.github.com/stephenparish/9941e89d80e2bc58a153)

The commit message must respect the following convention

```
<type>(<scope>): <subject>
```

**Example**

```
feat(authentication): Create authentication screen
```

**Accepted prefix list**

Accepted prefix list is the same as the branch prefix list

* feat
* fix
* hotfix
* docs
* style
* refactor
* chore

## Pull Requests

Each change must be proposed to merge using a `Pull Request` from the current branch to the main one

For more information about `Pull Request` creation please visit [https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request)

