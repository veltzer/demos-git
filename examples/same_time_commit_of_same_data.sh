#!/bin/bash -e

source common.sh

common_cleanup
common_repo_with_one_commit repo1 "first commit"
common_repo_with_one_commit repo2 "first commit"
echo "notice that these commits, from two different repos, have the same id!"
common_show_history repo1
common_show_history repo2
common_cleanup
