#!/bin/bash

source common.sh

if [ -d demo ]
then
	rm -rf demo
fi
git init demo
cd demo
commits 10 "commits"
echo -e "\n\nbefore revert"
git log --oneline

echo -e "\n\ndoing revert"
git reset --hard HEAD~5

echo -e "\n\nafter revert"
git log --oneline
cd ..
rm -rf demo
