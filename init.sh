#!/bin/sh
dir=`pwd`
git pull

cd ~/Sites

if [ ! -d "link" ]; then
	echo "Cloning project"
	git clone https://github.com/majest/link.git
else
	cd link
	git pull
	git submodule update --init --recursive
fi

cd $dir
vagrant up
sudo ipfw flush
sudo ipfw add 100 fwd 127.0.0.1,2345 tcp from any to me 80
sudo ipfw add 101 fwd 127.0.0.1,8443 tcp from any to me 443
vagrant ssh
