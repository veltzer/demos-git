#!/bin/bash -e

source common.sh

common_cleanup
common_create_repo_with_one_commit repo1 "first commit"
common_create_repo_with_one_commit repo2 "first commit"
common_notice "notice that these commits, from two different repos, have the same id!"
common_show_history repo1 > /tmp/hist_repo1
common_log repo1
common_show_history repo2 > /tmp/hist_repo2
common_log repo2
diff /tmp/hist_repo{1,2}
common_cleanup
