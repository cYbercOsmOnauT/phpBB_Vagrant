# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Check if Trigger plugin is installed
  exec "vagrant plugin install vagrant-triggers; vagrant #{ARGV.join(" ")}" unless Vagrant.has_plugin? 'vagrant-triggers' || ARGV[0] == 'plugin'

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ubuntu/trusty64"
    config.vm.hostname = "local.web-coding.eu"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 80, host: 8181
  config.vm.network "forwarded_port", guest: 3306, host: 3308

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.99.99"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder "log/htdocs",   "/var/www/devsystem/htdocs-writes", owner: "www-data", group: "www-data"
  config.vm.synced_folder "src/devsystem/phpBB", "/var/www/devsystem/htdocs-phpBB",    owner: "www-data", group: "www-data"
  config.vm.synced_folder "log/logs",     "/var/www/devsystem/logs",          owner: "www-data", group: "www-data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
      vb.memory = 2048
      vb.cpus   = 2
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

    config.trigger.after :up do
        # Start OverlayFS for WriteDirs
        run_remote "[ $(mount | grep -c overlayfs) == 1 ] || sudo service overlayfs start && sudo service overlayfs restart"
        # Check if config.php exists in the upperdir of OverlayFS
        run_remote "[ -f /var/www/devsystem/htdocs-writes/config.php ] || cp /vagrant/provision/config.php /var/www/devsystem/htdocs-writes/config.php"
        # I don't know why but mysqld seems to need a restart
        run_remote "service mysql restart"
    end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", inline: <<-SHELL
    sudo bash /vagrant/provision/provision.sh
  SHELL
end
