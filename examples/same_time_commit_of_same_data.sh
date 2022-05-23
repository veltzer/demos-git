#!/bin/bash
rm -rf example1 example2
git init example1
git init example2
cd example1
echo hello > hello.txt
git add hello.txt
cd ../example2
echo hello > hello.txt
git add hello.txt

# we you ready?
git commit -m "first commit"
cd ../example1
git commit -m "first commit"

# lets show the git log of the two project
git log
cd ../example2
git log
