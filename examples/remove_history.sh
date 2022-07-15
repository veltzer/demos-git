#!/bin/bash -e

# This example shows how to remove history
# It seems that shallow-exclude and --depth are only usable for remote repos
# and that's why this script clones a remote repo

source common.sh

echo "original repo"
rm -rf pytconf
git clone git@github.com:veltzer/pytconf.git
cd pytconf
git log --oneline | head -13

echo "shallow repo"
rm -rf pytconf
git clone git@github.com:veltzer/pytconf.git --depth=10
cd pytconf
git log --oneline
