#!/bin/bash -e

# This is a simple demo that creates a repo with commits and shows it's history

source common.sh

common_setup
common_create_repo_with_commits demo 10 "commit"
common_show_history demo
common_finish
