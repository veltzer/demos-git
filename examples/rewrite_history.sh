#!/bin/bash -e

# This is an exmample of how to rewrite history using "git filter-branch"
# References:
# - https://gist.github.com/kanzure/5558267

source common.sh

common_setup
common_create_repo_with_commits demo 10 "name"
common_show_history demo
common_cd_repo demo
export FILTER_BRANCH_SQUELCH_WARNING=1
# In order to do the "if [ -f name_4 ]" in the following line we have to use 'tree-filter'
# and not 'index-filter' because tree-filter checks out the files while index-filter does not.
# git filter-branch --tree-filter "if [ -f name_4 ]; then git rm --cached name_4; fi" --prune-empty
# git filter-branch --index-filter "git rm --cached --ignore-unmatch name_4" --prune-empty
git filter-repo --force --use-base-name --path "name_4" --invert-paths
echo "see, there is no name_4 file..."
ls -l
common_cd_repo_back
common_finish
