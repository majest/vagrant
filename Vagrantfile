# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"


Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "precise32.box"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"
  config.vm.network :forwarded_port, guest: 80, host: 8080
 
  config.vm.provision :chef_solo do |chef|


     	chef.cookbooks_path = "chef/cookbooks"
        chef.data_bags_path = "chef/data_bags"

        chef.add_recipe "apt"
	chef.add_recipe "build-essential"
        chef.add_recipe "git"
        chef.add_recipe "apache2"
        chef.add_recipe "apache2::mod_rewrite"
        chef.add_recipe "apache2::mod_ssl"
        chef.add_recipe "php"
	chef.add_recipe "php::module_mongo"
        chef.add_recipe "php::module_mysql"
        chef.add_recipe "php::module_apc"
        chef.add_recipe "php::module_sqlite3"
        chef.add_recipe "php::module_gd"
        chef.add_recipe "chef-php-extra"
        chef.add_recipe "apache2::mod_php5"
        chef.add_recipe "apache-sites"
        chef.add_recipe "composer"
        chef.add_recipe "vim"

        chef.json.merge!({
            "sites" => ["default"]
        })

	end

	config.vm.synced_folder "~/Sites", "/var/www/sites"
	config.vm.provision :shell, :path => "init.sh"

end
