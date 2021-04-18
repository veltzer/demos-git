#!/bin/bash

# This example shows how to remove history
# This uses the shallow features
# References:
# - https://stackoverflow.com/questions/4515580/how-do-i-remove-the-old-history-from-a-git-repository

source common.sh

rm -rf project
git init project
cd project
commits 10 "commit name"
git log --oneline
git rev-parse HEAD~5 > .git/shallow
git fsck --unreachable # Will show you the list of what will be deleted
git gc --prune=now # Will actually delete your data
git log --oneline
