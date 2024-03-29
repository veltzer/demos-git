#!/bin/bash -e

# cleanup
rm -rf server user?

git init --bare server
git clone server user1
cd user1
touch hello.txt
git add hello.txt
git commit -m "first commit"
git push
cd ..

cd user1
git branch feature_x
git checkout feature_x
common_create_commits feature_x 10 "name"
git push --set-upstream origin feature_x
cd ..
