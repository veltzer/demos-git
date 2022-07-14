function common_cleanup() {
	rm -rf playground/*
}

function common_create_commits() {
	local number=$1
	local name=$2
	let x=1
	while [[ $x -le ${number} ]]
	do
		touch "${name}_${x}"
		git add "${name}_${x}"
		git commit -m "${name} commit ${x}"
		let "x=x+1"
	done
}

function common_show_history() {
	local repo=$1
	local folder="playground/${repo}"
	cd "${folder}"
	git log --pretty=format:"%h %s" --graph
	cd ../../
}

function common_repo_with_one_commit() {
	local repo=$1
	local name=$2
	local folder="playground/${repo}"
	git init "${folder}"
	cd "${folder}"
	common_create_commits 1 $name
	cd ../../
}

function common_create_repo_with_commits() {
	local repo=$1
	local number=$2
	local name=$3
	local folder="playground/${repo}"
	git init "${folder}"
	cd "${folder}"
	common_create_commits $number $name
	cd ../../
}

function common_server_two_users() {
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

function common_waitkey() {
	if [[ $do_wait -eq 1 ]]
	then
		read
	fi
}

debug=false

function common_debug() {
	local msg=$1
	if $debug
	then
		echo $msg
	fi
}