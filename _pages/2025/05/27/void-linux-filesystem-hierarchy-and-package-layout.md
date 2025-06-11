---
Title: Void Linux Filesystem Hierarchy and Package Layout
date: 2025-05-27
categories:
    - /development
    - /linux
    - /reference
tags:
    - unix
    - linux
    - void-linux
    - xbps
    - package-managers
    - software-development
    - software-engineering
    - sysadmin
    - system-administration
    - code
    - computer-programming
    - programming
    - posix
    - operating-systems
    - os
    - xdg
    - freedesktop-org
    - specification
---


**Void Linux** is an independent, minimalist, and musl/glibc-compatible Linux distribution with a focus on simplicity, transparency, and pragmatism. It adheres closely to the traditional **Filesystem Hierarchy Standard (FHS)**, with some lean deviations. It uses its own native package manager: `xbps` (X Binary Package System).

---

## Core Directory Structure

Void Linux keeps a clean and conventional Unix-style layout:

|Directory|Purpose|
|---|---|
|`/`|Root of the entire filesystem tree|
|`/bin`|Essential user binaries (`ls`, `sh`, `cp`, etc.)|
|`/sbin`|Essential system binaries (`init`, `reboot`, etc.)|
|`/usr/bin`|Most user commands (`gcc`, `vim`, `python`, etc.)|
|`/usr/sbin`|Non-essential system binaries (admin tools)|
|`/usr/lib`|Shared libraries for `/usr/bin` and `/usr/sbin`|
|`/lib`|Shared libraries for `/bin` and `/sbin`|
|`/etc`|System-wide configuration files|
|`/var`|Variable data: logs, databases, lock files|
|`/tmp`|Temporary files, cleared at reboot|
|`/home`|User home directories|
|`/root`|Home for the root user|
|`/dev`, `/proc`, `/sys`|Device and kernel interfaces (virtual filesystems)|

Void is notable for **not using `systemd`** — it uses **`runit`** as its init system, which is simple, fast, and easy to understand.

---

## Where Software is Installed

Void uses the `xbps` package manager and a repository of prebuilt binaries.

|Software Type|Location|
|---|---|
|CLI tools|`/usr/bin`, `/bin`|
|Libraries|`/usr/lib`, `/lib`|
|Config files|`/etc/`|
|Docs / man pages|`/usr/share/doc`, `/usr/share/man`|
|Services (runit)|`/etc/sv/`, `/var/service/`|
|Source packages (srcpkgs)|`/usr/src`, or user-defined repo|

Packages are typically installed under `/usr` to keep the root filesystem clean and minimal.

---

## runit Service Structure

Void's service model uses `runit`, with simple symlink-based service management:

|Directory|Role|
|---|---|
|`/etc/sv/`|Definitions of all available services|
|`/var/service/`|Active services (symlinks to `/etc/sv`)|
|`/etc/runit/`|Init stages (1, 2, 3 scripts)|

Services are enabled via:

```bash
ln -s /etc/sv/sshd /var/service/
```

No `systemctl`, no unit files — just directories and shell scripts.

---

## Package Management with XBPS

Void uses `xbps-install`, `xbps-query`, and `xbps-remove`:

- Install a package:
    
    ```bash
    xbps-install vim
    ```
    
- Query installed packages:
    
    ```bash
    xbps-query -l
    ```
    
- Remove a package:
    
    ```bash
    xbps-remove -R package
    ```
    

Build packages from source using **`xtools`** and **`void-packages`** repo.

---

## User-Level Conventions (XDG & Shell)

Void doesn't impose dotfile clutter. Most CLI tools follow **XDG Base Directory Specification** by default or via patches.

|XDG Variable|Default Path|Purpose|
|---|---|---|
|`$XDG_CONFIG_HOME`|`~/.config`|User config files|
|`$XDG_DATA_HOME`|`~/.local/share`|App data (plugins, histories)|
|`$XDG_CACHE_HOME`|`~/.cache`|Cached, non-essential files|
|`$XDG_STATE_HOME`|`~/.local/state`|Logs and state info|

Void doesn't ship a desktop environment, but if you install one (e.g., GNOME, XFCE, sway), these paths are respected.

---

## Comparison: Void vs Other Distros

|Feature|Void Linux|Debian/Ubuntu|Arch Linux|
|---|---|---|---|
|Init system|`runit`|`systemd`|`systemd`|
|Package manager|`xbps`|`apt`|`pacman`|
|System layout|FHS|FHS|FHS|
|GUI apps preinstalled|❌ No|✅ Yes (Desktop ISOs)|❌ No|
|Source packages|`/usr/src` or user-defined|`/usr/src`|AUR `/home/username`|
|Default desktop|None|GNOME or XFCE|None|

---

## Security & Minimalism

Void does not include:

- No `sudo` by default (you install it yourself)
    
- No setuid binaries unless you enable them
    
- No preinstalled GUI apps
    
- No telemetry or automatic services

---

## Summary

Void Linux follows a clean, transparent Unix-style layout:

- **No `systemd`, no bloat** — just clean `runit` init and fast boots.
    
- **Traditional FHS**, with `/usr`-first binary layout.
    
- **Package manager (`xbps`)** that's fast, self-contained, and easy to understand.
    
- **XDG compliant**, but not invasive.
    

---

## See Also

- [Category: /development](/notes-by-category#category-/development)

- [Category: /linux](/notes-by-category#category-/linux)

