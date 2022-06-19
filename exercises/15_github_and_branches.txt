1. Create a github account.
2. Create a private/public keypair and add it to your github account.
	https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
3. Configure git to use your newly created private/public keypair.
	You should add something like this to your ~/.gitconfig:
===============
	[user]
		signingkey = 73C128F9
===============
	Your key id is the last 8 characters of your full key id.
	You can use either a text editor or:
	$ git config --global user.signingkey [yourkeyid]
4. Create a repository in your github account.
5. Clone your project to your laptop/desktop.
6. add files, commit, see your change in github.com
7. create branches commit on them and see them in github.com
