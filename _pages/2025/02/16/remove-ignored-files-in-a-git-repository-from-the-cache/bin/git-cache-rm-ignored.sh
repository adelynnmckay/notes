#!/bin/bash

set -oue pipefail

# Step 1: Change directory to the root directory of the git repository
cd "$(git rev-parse --show-toplevel)"

# Step 2: Remove ignored files from the Git index, but keep them in the working directory
git rm -r --cached .

# Step 2: Re-add all the remaining files (that are not ignored)
git add .

# Step 3: Commit the changes
git commit --allow-empty-message -m ''

# Step 4: Change directory back to the original current working directory 
cd -