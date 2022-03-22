#!/bin/bash -e

# This is the third question
rm -rf server user1 user2
git init --bare server
git clone server user1
git clone server user2
cd user1
cp /etc/passwd . 
git add passwd
git commit -m "first commit"
git push
cd ../user2
git pull
echo "user2 was here..." >> passwd
git add passwd
git commit -m "user2 commit"
git push
cd ../user1
echo "user1 was here..." >> passwd
git add passwd
git commit -m "user1 commit"
if ! git push
then
	echo "push without pull failed!"
fi
git pull
