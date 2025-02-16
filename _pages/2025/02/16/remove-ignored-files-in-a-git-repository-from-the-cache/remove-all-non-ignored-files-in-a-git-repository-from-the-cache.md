---
title: Remove Ignored Files in a Git Repository From the Cache
date: 2025-02-16
tags:
    - git
    - gitignore
    - software
    - software-development
    - software-engineering
    - code
    - programming
category:
    - /software/git
---

Adding files to a `.gitignore` does not actually remove them from the git cache. For that, we need to do a bit more work. 

Here's a script that lets you do that for all files in a git repository. Note that it performs a commit that you will probably want to `git commit --amend` afterwards.

```bash
```
{: data-src='/pages/2025/02/16/remove-ignored-files-in-a-git-repository-from-the-cache/bin/git-cache-rm-ignored.sh' }