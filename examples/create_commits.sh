#!/bin/bash
name=$(basename $PWD)
branch=$(git rev-parse --abbrev-ref HEAD)
for i in {1..5}; do touch ${branch}${name}$i.txt; git add ${branch}${name}$i.txt; git commit -m "${branch} ${name} $i"; done
sleep 1
