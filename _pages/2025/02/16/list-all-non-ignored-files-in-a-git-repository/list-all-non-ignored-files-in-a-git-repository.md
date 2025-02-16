---
title: List All Files in a Git Repository That Are Not Ignored
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

Here's a script to list all files in a git repository that are not ignored by a `.gitignore`. It is super useful for pretty much anything that requires recursively listing or iterating over files in a git repo, which I find myself doing quite a lot. Also, if you execute it from a subdirectory, it will only list those files under that subdirectory, as opposed to all files in the repository.


```bash
```
{: data-src='/pages/2025/02/16/list-all-non-ignored-files-in-a-git-repository/bin/git-file-ls.sh' }