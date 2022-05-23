#!/bin/bash -e

# This is the third question
rm -rf server user1 user2
git init --bare server
git clone server user1
git clone server user2
cd user1
for x in {1..3}
do
	touch $x.txt
	git add $x.txt
	git commit -m "user1 commit $x"
done
cd ../user2
for x in {1..3}
do
	touch $x.txt
	git add $x.txt
	git commit -m "user2 commit $x"
done
git push
cd ../user1
if ! git push
then
	echo "yes! user1 could not push his changed to the server..."
fi
