#!/bin/bash -e

source common.sh

common_cleanup
common_create_repo_with_commits demo 5 "commit"
echo "before revert"
common_show_history demo
common_cd_repo demo
git revert HEAD --no-edit
common_cd_repo_back
echo "after revert"
common_show_history demo
common_cleanup
