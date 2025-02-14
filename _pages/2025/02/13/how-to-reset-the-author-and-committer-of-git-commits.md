---
title: How to Reset the Author and Committer of Git Commits
date: 2025-02-13
tags:
    - git
    - software
    - software-development
    - software-engineering
    - code
    - programming
    - version-control
    - terminal-one-liners
category:
    - /software/git
---

Here's how to reset the author and committer -- both user *and* email -- for git commits.

First, ensure the both the user and email are set; otherwise only the author will be reset, but not the committer.

```sh
$ git config --global user.name "New Author Name"
$ git config --global user.email "<email@address.example>"
```

Then, for the most recent commit:

```sh
$ git commit --amend --no-edit --reset-author
```

Or, for a range of commits:

```sh
$ git rebase -r <some-commit> --exec 'git commit --amend --no-edit --reset-author'
```

Or, for all commits:

```sh
$ git rebase -r --root --exec "git commit --amend --no-edit --reset-author"
```

Note that if you do `--author "New Author Name <email@address.example>"` instead of `--reset-author` it will only update the author, not the committer.