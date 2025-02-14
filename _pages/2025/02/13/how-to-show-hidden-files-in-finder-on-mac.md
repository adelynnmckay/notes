---
title: How to Show Hidden Files in Finder on Mac
date: 2025-02-13
tags:
    - mac
    - mac-os
    - software
    - software-engineering
    - terminal-one-liners
    - coding
    - programming
    - commands
category:
    - /software/mac/commands
---

To enable showing hidden files in finder on a Mac, open a terminal and do

```sh
$ defaults write com.apple.Finder AppleShowAllFiles true
```

Then restart finder with

```sh
$ killall Finder
```
