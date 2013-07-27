#!/bin/sh
dir=`pwd`



if ! command -v chef-solo | grep chef; then
echo "Enter your admin password"
sudo true && curl -L https://www.opscode.com/chef/install.sh | sudo bash
fi

if ! command VirtualBox --help | head -1 | grep Oracle; then
echo "Virtual Box is not installed"
curl -L http://download.virtualbox.org/virtualbox/4.2.16/VirtualBox-4.2.16-86992-OSX.dmg >  ~/Downloads/VirtualBox-4.2.16-86992-OSX.dmg
echo ""
echo "Install Virtual Box and rerun the script"
exit 1;
fi

git pull

cd ~/Sites

echo "Enter your git password"
if [ ! -d "link" ]; then
	echo "Cloning project"
	git clone https://github.com/majest/link.git
else
	cd link
	git pull
	git submodule update --init --recursive
fi

cd $dir
make vagrant-clean
#vagrant reload
echo "Cleating firewall, press y to accept changes"
sudo ipfw flush
sudo ipfw add 100 fwd 127.0.0.1,2345 tcp from any to me 80
sudo ipfw add 101 fwd 127.0.0.1,8443 tcp from any to me 443
vagrant ssh
