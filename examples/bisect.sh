#!/bin/bash -e

# This is a demo of running git bisect

# shellcheck source=examples/common.sh
source common.sh

common_setup
common_create_repo demo
common_cd_repo demo
cat << EOF > test.sh
#!/bin/bash

test ! -f commit_57
EOF
chmod +x ./test.sh
git add test.sh
git commit -m "first commit"
common_cd_repo_back demo
common_create_commits demo 100 commit
common_cd_repo demo
git bisect start HEAD HEAD~100
git bisect run "./test.sh"
common_cd_repo_back demo
# common_show_history demo
common_finish
