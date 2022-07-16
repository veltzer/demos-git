#!/bin/bash -e

# https://devconnected.com/how-to-undo-last-git-commit/

source common.sh

common_setup
common_create_repo_with_commits demo 5 "commit"
echo "before revert"
lines_before=$(common_show_history demo | wc -l)
common_cd_repo demo
git revert HEAD --no-edit
common_cd_repo_back
echo "after revert"
lines_after=$(common_show_history demo | wc -l)
((lines_before=lines_before+1))
if [ "${lines_before}" -ne "${lines_after}" ]
then
	common_error "error"
fi
common_finish
