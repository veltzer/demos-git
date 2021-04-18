#!/bin/bash

# This is an exmample of how to rewrite history using "git filter-branch"
# References:
# - https://gist.github.com/kanzure/5558267

source common.sh

rm -rf project
git init project
cd project
commits 10 "commit name"
git log --oneline
git revert --no-edit HEAD~2 HEAD~4 HEAD~6 HEAD~8
git log --oneline
git ls-files
