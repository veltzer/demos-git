#!/bin/bash -e

# This is an exmample of how to rewrite history using "git-filter-repo"
# References:
# - https://github.com/newren/git-filter-repo

# shellcheck source=examples/common.sh
source common.sh

common_setup
common_create_repo_with_commits demo 10 "name"
common_show_history demo
common_cd_repo demo
git filter-repo --force --use-base-name --path "name_4" --invert-paths
echo "see, there is no name_4 file..."
ls -l
common_cd_repo_back
common_finish
