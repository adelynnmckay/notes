---
title: Completely Remove a Git Submodule From a Git Repo
date: 2025-02-16
tags:
    - git
    - git-submodule
    - software
    - software-development
    - software-engineering
    - code
    - programming
category:
    - /software/git
---

Doing a simple `git rm <my-submodule>` doesn't actually fully remove a submodule; it leaves a submodule directory at `.git/modules/<my-submodule>`, and a section in the `.gitmodules` file.

So here's a script to *completely* remove a submodule from a git repo. Note that it assumes that the submodule is at `./<my-submodule>` relative to the root of the git repository. You will have to adjust this if it is at a different path.

```bash
```
{: data-src='/pages/2025/02/16/completely-remove-a-submodule-of-a-git-repository/bin/git-submodule-rm.sh' }

This script is adapted from a [How do I remove a submodule?](https://stackoverflow.com/questions/1260748/how-do-i-remove-a-submodule) question on Stack Overflow.