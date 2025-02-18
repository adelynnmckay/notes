---
title: How to Zip a File or Directory with a Password
date: 2025-02-17
tags:
    - software
    - scripts
    - bash-script
    - shell-script
    - terminal
    - terminal-one-liners
    - privacy
    - information-security
    - infosec
    - opsec
    - security
category:
    - /software/scripts/security
---

**Zip and encrypt one or more files**

```sh
zip --encrypt <output-file>.zip <input-file-1> <input-file-2> ...
```

**Zip and encrypt a directory (recursive)**

```sh
zip -r --encrypt <output-file>.zip <input-directory>
```

**Decrypt a zip file**

```sh
unzip <input-file>.zip
```