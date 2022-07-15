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

cd ../user1
git branch feature_x
git checkout feature_x
../create_commits.sh
git push --set-upstream origin feature_x

cd ../user2
git branch feature_y
git checkout feature_y
../create_commits.sh
git push --set-upstream origin feature_y
