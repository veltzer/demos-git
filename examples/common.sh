function git_common_commits() {
	local number=$1
	local name=$2
	let x=1
	while [[ $x -le ${number} ]]
	do
		touch ${name}_${x}
		git add ${name}_${x}
		git commit -m "${name} commit ${x}"
		let "x=x+1"
	done
}

function git_common_repo_with_several_commits() {
	rm -rf repo
	git init repo
	cd repo
	commits 10 "just another"
	cd ../
}

function git_common_server_two_users() {
	rm -rf server user?
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
	cd ../
}

do_wait=0

function git_common_waitkey() {
	if [[ $do_wait -eq 1 ]]
	then
		read
	fi
}

function debug() {
	local msg=$1
	if $debug
	then
		echo $msg
	fi
}

debug=false

function debug() {
	local msg=$1
	if $debug
	then
		echo $msg
	fi
}
