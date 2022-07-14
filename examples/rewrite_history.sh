#!/bin/bash -e

# This is an exmample of how to rewrite history using "git filter-branch"
# References:
# - https://gist.github.com/kanzure/5558267

source common.sh

rm -rf project
git init project
cd project
commits 10 "commit name"
git log --oneline
git log | head -10
# sleep 10
export FILTER_BRANCH_SQUELCH_WARNING=1
# In order to do the "if [ -f name_4 ]" in the following line we have to use 'tree-filter'
# and not 'index-filter' because tree-filter checks out the files while index-filter does not.
git filter-branch --tree-filter "if [ -f name_4 ]; then git rm --cached name_4; fi" --prune-empty
# git filter-branch --index-filter "git rm --cached --ignore-unmatch name_4" --prune-empty
git log --oneline
