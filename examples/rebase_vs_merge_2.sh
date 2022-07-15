#!/bin/bash -e

source common.sh

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
echo "history for user1..."
git log --pretty=format:"%h %s" --graph
cd ../user2
echo "history for user2..."
git log --pretty=format:"%h %s" --graph
echo "histories above should be the same..."
echo "press any key..."
git_common_waitkey
cd ../user1
for i in {1..5}; do touch user1change$i.txt; git add . ; git commit -m "user1 change $i"; done
cd ../user2
for i in {1..3}; do touch user2change$i.txt; git add . ; git commit -m "user2 change $i"; done

cd ../user1
echo "history for user1..."
git log --pretty=format:"%h %s" --graph
cd ../user2
echo "history for user2..."
git log --pretty=format:"%h %s" --graph
echo "histories above are different..."
echo "press any key..."
git_common_waitkey

echo "user1 pushed..."
cd ../user1
git push
echo "press any key..."
git_common_waitkey

echo "user2 cannot push..."
cd ../user2
git push
echo "press any key..."
git_common_waitkey

echo "user2 pulls..."
git pull --rebase
echo "user2 pushes..."
git push
echo "user1 pulls..."
cd ../user1
git pull

echo "recording logs for posterity..."
git log --pretty=format:"%h %s" --graph > ../user1_rebase_log.txt
cd ../user2
git log --pretty=format:"%h %s" --graph > ../user2_rebase_log.txt
