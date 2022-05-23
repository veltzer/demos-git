#!/bin/bash
rm -rf server user1 user2
git init --bare server
git clone server user1
cd user1
touch hello.txt
git add hello.txt
git commit -m "first commit"
git push
