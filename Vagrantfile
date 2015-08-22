# -*- mode: ruby -*-
# vi: set ft=ruby :


$setup_puppet = <<END
echo 'supercede domain-name "silicon.cat";' > /etc/dhcp/dhclient.conf

wget https://apt.puppetlabs.com/puppetlabs-release-pc1-trusty.deb
sudo dpkg -i puppetlabs-release-pc1-trusty.deb
sudo apt-get update
sudo apt-get install -y puppet-agent
END

$setup_puppetserver = <<END
  echo 'supercede domain-name "silicon.cat";' > /etc/dhcp/dhclient.conf

  wget https://apt.puppetlabs.com/puppetlabs-release-pc1-trusty.deb
  sudo dpkg -i puppetlabs-release-pc1-trusty.deb
  sudo apt-get update
  sudo apt-get install -y puppetserver
  sudo service puppetserver start
END

nodes = [
  { :hostname => 'puppet',   :ip => '192.168.250.2' },
  { :hostname => 'zoo-1',   :ip => '192.168.250.50' },
  { :hostname => 'storm-worker-1',      :ip => '192.168.250.201' },
  { :hostname => 'storm-worker-2',    :ip => '192.168.250.202' },
]


# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ubuntu/trusty64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
  end

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   sudo apt-get update
  #   sudo apt-get install -y apache2
  # SHELL


  nodes.each do |node|
    config.vm.define node[:hostname] do |nodeconfig|
      nodeconfig.vm.hostname = node[:hostname] + ".silicon.cat"
      nodeconfig.vm.network :private_network, ip: node[:ip]
      #nodeconfig.vm.provision "shell", inline: $setup_puppet

      memory = node[:ram] ? node[:ram] : 512;
      nodeconfig.vm.provider :virtualbox do |vb|
        vb.customize [
          "modifyvm", :id,
          "--cpuexecutioncap", "50",
          "--memory", memory.to_s,
        ]
      end
    end
  end

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file = "site.pp"
    puppet.module_path = ["puppet/modules", "puppet/vendor/modules"]
  end

  # Puppet Server
  #config.vm.define "puppetserver", autostart: false do |puppetserver|
  #  puppetserver.vm.hostname = "puppet.silicon.cat"
  #  puppetserver.vm.network :private_network, ip: "192.168.250.1"
  #  puppetserver.vm.provision "shell", inline: $setup_puppetserver
  #  puppetserver.vm.provider :virtualbox do |ps|
  #    ps.memory = 1024
  #  end
  #end
end


