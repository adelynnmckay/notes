---
title: How to Use NX for Monorepos
date: 2025-02-16
tags:
    - build-system
    - monorepo
    - software
    - software-development
    - software-engineering
    - code
    - programming
    - npm
    - javascript
    - typescript
category:
    - /software/build-systems
---

## Introduction

NX is a powerful build system for managing monorepos efficiently. This guide covers how to configure an NX-based monorepo using `npm`, set up package structures, and streamline the build process.

## Configuration

We will use `npm` for package management, script execution, and dependency resolution. Each package will have its own `package.json` file, while the monorepo configuration resides in a top-level `package.json`.

### Monorepo `package.json`

The root `package.json` should look like this:

```json
{
  "private": true,
  "name": "<repository-name>",
  "version": "1.0.0",
  "workspaces": ["<packages-dir>/**"],
  "scripts": {
    "build": "nx run-many --target=build --all"
  }
}
```

#### Explanation:
- **`private: true`** - Marks the monorepo as private, preventing it from being published.
- **`name`** - The monorepo's name (can be arbitrary).
- **`version`** - The monorepo's version.
- **`workspaces`** - Defines workspace packages using the `<packages-dir>/**` glob pattern to include subdirectories recursively.
- **`scripts`** - Defines reusable npm scripts. Here, `build` uses NX to execute all package build scripts efficiently, resolving dependencies automatically.

### Package `package.json`

Each package should have its own `package.json`:

```json
{
  "name": "@<package-org>/<package-name>",
  "version": "1.0.0",
  "bin": {
    "<exe-name>": "bin/<exe-name>.sh"
  },
  "scripts": {
    "build": "mkdir -p dist && echo 'Hello, World!' > dist/hello-world.txt"
  },
  "files": ["bin/**/*", "dist/**/*"]
}
```

#### Explanation:
- **`name`** - The package name, prefixed with an organization name using `@`.
- **`version`** - The package version.
- **`bin`** - Specifies executables that will be linked to `node_modules/.bin/` for easy access.
- **`scripts`** - Defines scripts, including a `build` script that generates a sample output file.
- **`files`** - Specifies files to include in the package when installed in `node_modules`.

## Build and Install

Follow these steps to set up and build your monorepo.

### 1. Create the Root `package.json`

```json
{
  "private": true,
  "name": "<repository-name>",
  "version": "1.0.0",
  "workspaces": ["<packages-dir>/**"],
  "scripts": {
    "build": "nx run-many --target=build --all"
  },
  "devDependencies": {}
}
```

### 2. Install Dependencies

#### Install npm (if not installed)
```bash
brew install npm
```

#### Install `jq` (for JSON parsing)
```bash
brew install jq
```

#### Install NX as a Dev Dependency
```bash
cd <repository-dir>
npm install --save-dev nx
```

#### Install All Dependencies
```bash
cd <repository-dir>
npm install
```

### 3. Build All Packages

Ensure your packages under `<packages-dir>` have their own `package.json` files with `build` scripts defined. Then run:

```bash
cd <repository-dir>
npm run build
```

### 4. Link Package Executables

This step links executables defined in the `bin` field to `node_modules/.bin`.

```bash
cd "<repository-dir>"
for package in $(find "<packages-dir>" -name package.json); do
    if jq -e 'has("bin")' "$package" >/dev/null; then
        package_dir=$(dirname "$package")
        (cd "$package_dir" && npm link)
    fi
done
```

### 5. Add Executables to Path (Optional)

To make scripts globally accessible, add `node_modules/.bin` to your system path:

```bash
cd <repository-dir>
echo 'export PATH=$(pwd)/node_modules/.bin:$PATH' >> ~/.bashrc
echo 'export PATH=$(pwd)/node_modules/.bin:$PATH' >> ~/.zshrc
source ~/.bashrc || source ~/.zshrc
```

## Conclusion

By following this guide, you have successfully set up an NX-powered monorepo with npm workspaces. This structure enables efficient dependency resolution, scalable builds, and seamless script execution across multiple packages. Happy coding!

