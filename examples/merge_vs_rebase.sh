#!/bin/bash -e

source common.sh

function doit() {
	local rebase=$1
	rm -rf demo
	git init demo
	cd demo
	
	# create the first commit
	touch hello.txt
	git add hello.txt
	git commit -m "first commit"

	git branch branch
	git_common_commits 3 m
	git log --oneline	
	echo "====================================="
	git switch branch
	git_common_commits 3 b
	git pull --rebase=true . master
	git log --oneline
	echo "====================================="

	git switch master
	git pull --rebase=false . branch 2> /dev/null > /dev/null
	git log --oneline
}

doit 0
