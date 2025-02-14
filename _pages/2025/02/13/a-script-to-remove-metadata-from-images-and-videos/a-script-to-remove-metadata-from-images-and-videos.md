---
title: A Script to Remove Metadata from Images and Videos
date: 2025-02-13
tags:
    - bash
    - sh
    - software
    - software-development
    - software-engineering
    - code
    - programming
    - bash-script
    - shell-script
    - terminal
    - privacy
    - social-media
    - information-security
    - infosec
    - opsec
    - security
category:
    - /software/scripts/security
---

Images and videos contain hidden metadata that can reveal **sensitive personal information**. This includes **GPS coordinates**, which can expose your **home, workplace, or frequent locations**, **timestamps** that reveal when media was taken, and **device details** such as camera make, model, and serial number, which can link multiple files to the same person. Metadata may also store **usernames, file paths, editing history, and software details**, potentially exposing your **identity or workflow**.  

Removing metadata is crucial for **privacy and security**. It prevents **location tracking, digital fingerprinting, and unintentional leaks of personal data**. Stripping metadata before posting photos or videos online is essential to avoid **accidental exposure of private information**. By ensuring files contain only the visible content, you reduce the risk of **being tracked, identified, or exploited**.

So I wrote a simple bash script I use literally *all* the time that removes identifying metadata from images and video files. In fact, the script actually even runs as part of the build of this site. 

## Features

- ✅ **Minimal dependencies, uses `exiftool` & `ffmpeg`**  
- ✅ **Cross platform, runs on macOS (with `brew`) and Linux (with `apt-get`)**
- ✅ **Automatically checks for dependencies `exiftool` & `ffmpeg`**  
- ✅ **Installs missing dependencies (`brew` for macOS, `apt-get` for Linux)**  
- ✅ **Processes files & directories**  
- ✅ **Supports recursive mode (`--recursive`)**  
- ✅ **Debug mode (`--debug`)**  
- ✅ **Help text (`-h` or `--help`)**  
- ✅ **Handles both images & videos**  
- ✅ **Safe operations (won't modify unsupported files)**  

## Usage

**Basic Usage (Single File)**

```bash
./rm_metadata.sh path/to/image.jpg
```

**Process All Images & Videos in a Directory**

```bash
./rm_metadata.sh path/to/directory
```

**Process All Images & Videos Recursively**

```bash
./rm_metadata.sh --recursive path/to/directory
```

**Enable Debug Mode**

```bash
./rm_metadata.sh --debug path/to/directory
```

**Display Help**

```bash
./rm_metadata.sh --help
```

## Design

The meat and matter of the script comes down to two basic commands.

One which uses `exiftool` to remove metadata from images:

```sh
exiftool -all= -overwrite_original "$file"
```

And one which uses `ffmpeg` to remove metadata from videos:

```sh
ffmpeg -i "$file" -map_metadata -1 -c:v copy -c:a copy "clean_$file"
```

## Implementation

Here's the full script, you can also download and access a raw version [here](/pages/2025/02/13/a-script-to-remove-metadata-from-images-and-videos/rm_metadata.sh).

```bash
```
{: data-src='/pages/2025/02/13/a-script-to-remove-metadata-from-images-and-videos/rm_metadata.sh' }
