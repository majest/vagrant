#!/bin/sh
dir=`pwd`

if ! command -v vagrant | grep vagrant; then
echo "Vagrant not found. Downloading file to Downloads directory"
curl -L http://files.vagrantup.com/packages/22b76517d6ccd4ef232a4b4ecbaa276aff8037b8/Vagrant-1.2.6.dmg > ~/Downloads/Vagrant-1.2.6.dmg
echo "Install Vagrant and restart the script. (Vagrant file in downloads directory)"
fi


if ! command -v chef-solo | grep chef; then
sudo true && curl -L https://www.opscode.com/chef/install.sh | sudo bash
fi

if ! command -v VirtualBox | grep VirtualBox; then
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
vagrant up
echo "Cleating firewall, press y to accept changes"
sudo ipfw flush
sudo ipfw add 100 fwd 127.0.0.1,2345 tcp from any to me 80
sudo ipfw add 101 fwd 127.0.0.1,8443 tcp from any to me 443
vagrant ssh
