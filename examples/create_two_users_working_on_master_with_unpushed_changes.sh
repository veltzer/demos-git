#!/bin/bash -e

# cleanup
rm -rf server user1 user2

git init --bare server
git clone server user1
git clone server user2
cd user1
touch hello.txt
git add hello.txt
git commit -m "first commit"
git push
cd ../user2
git pull

common_create_commits user1 10 "name"
common_create_commits user2 10 "name"
