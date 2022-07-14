#!/bin/bash -e

source common.sh

common_cleanup
common_create_repo_with_commits demo 10 "commit"
echo "before reset"
common_show_history demo
common_cd_repo demo
git reset --hard HEAD~5
common_cd_repo_back
echo "after reset"
common_show_history demo
echo "adding new commits"
common_create_commits demo 5 "new commit"
common_show_history demo
common_cleanup
