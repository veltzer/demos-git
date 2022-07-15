#!/bin/bash -e

rm -rf example
git init example
cd example
touch hello.txt
git add hello.txt
git commit -m "first commit"

git checkout master
git checkout -b feature_x
for x in {1..4}; do touch x_$x; git add x_$x; git commit -am "feature_x commit $x"; done
git checkout master
git checkout -b feature_y
for x in {1..4}; do touch y_$x; git add y_$x; git commit -am "feature_y commit $x"; done

git checkout master
