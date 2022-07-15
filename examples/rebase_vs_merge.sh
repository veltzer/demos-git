#!/bin/bash -e

source common.sh

function doit() {
	local rebase=$1
	rm -rf server user1 user2
	git init --bare server
	git clone server user1
	git clone server user2
	cd user1
	touch hello.txt
	git add hello.txt
	git commit -m "first commit"
	git push
	cd ../user2
	git pull
	cd ../user1
	debug "history for user1..."
	git log --pretty=format:"%h %s" --graph
	cd ../user2
	debug "history for user2..."
	git log --pretty=format:"%h %s" --graph
	debug "histories above should be the same..."
	debug "press any key..."
	git_common_waitkey
	cd ../user1
	for i in {1..5}; do touch user1change$i.txt; git add . ; git commit -m "user1 change $i"; done
	cd ../user2
	for i in {1..3}; do touch user2change$i.txt; git add . ; git commit -m "user2 change $i"; done

	cd ../user1
	debug "history for user1..."
	git log --pretty=format:"%h %s" --graph
	cd ../user2
	debug "history for user2..."
	git log --pretty=format:"%h %s" --graph
	debug "histories above are different..."
	debug "press any key..."
	git_common_waitkey

	debug "user1 pushed..."
	cd ../user1
	git push
	debug "press any key..."
	git_common_waitkey

	debug "user2 cannot push..."
	cd ../user2
	git push
	debug "press any key..."
	git_common_waitkey

	debug "user2 pulls..."
	if $rebase
	then
		git pull --rebase=true --no-edit
	else
		git pull --rebase=false --no-edit
	fi
	debug "user2 pushes..."
	git push
	debug "user1 pulls..."
	cd ../user1
	git pull

	debug "recording logs for posterity..."
	debug "user1"
	git log --pretty=format:"%h %s" --graph > /tmp/log1_$rebase
	debug "user2"
	cd ../user2
	git log --pretty=format:"%h %s" --graph > /tmp/log2_$rebase

	diff /tmp/log1_$rebase /tmp/log2_$rebase

	cd ..
	rm -rf server user1 user2
}


exec 3>&1 4>&2 1> /dev/null 2> /dev/null

debug merge
doit false
debug rebase
doit true

exec 1>&3 2>&4

# show results
echo "merge log"
cat /tmp/log1_false
echo
echo
echo "rebase log"
cat /tmp/log1_true
echo
