#!/bin/bash -e

# This is an example of how to revert severl commits
# References:
# - https://gist.github.com/kanzure/5558267

source common.sh

common_setup
common_create_repo_with_commits demo 10 "name"
echo "before revert"
lines_before=$(common_show_history demo | wc -l)
common_cd_repo demo
git revert --no-edit HEAD~2 HEAD~4 HEAD~6 HEAD~8
common_cd_repo_back
lines_after=$(common_show_history demo | wc -l)
((lines_before+=4))
if [ "${lines_before}" -ne "${lines_after}" ]
then
	common_error "error"
fi
common_finish
