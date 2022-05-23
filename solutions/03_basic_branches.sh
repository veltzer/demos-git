#!/bin/bash -ex

rm -rf demo
git init demo
cd demo
touch hello.txt
git add hello.txt
git commit -m "first commit"
for x in {1..3}
do
	touch "master$x.txt"
	git add "master$x.txt"
	git commit -m "master commit $x"
done
git switch -c branch1
for x in {1..3}
do
	touch "branch1$x.txt"
	git add "branch1$x.txt"
	git commit -m "branch1 commit $x"
done
echo hello
git switch master
for x in {4..6}
do
	touch "master$x.txt"
	git add "master$x.txt"
	git commit -m "master commit $x"
done
git switch -c branch2
git pull . branch1
git switch master
git pull . branch2
git switch branch1
git pull . master
git switch master
git pull . branch1
git branch -D branch1
git branch -D branch2
