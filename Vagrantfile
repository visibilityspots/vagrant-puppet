# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true

  config.vm.provider :virtualbox do |virtualbox, override|
    override.vm.box = "vStone/centos-6.x-puppet.3.x"
    virtualbox.customize ["modifyvm", :id, "--memory", 3072]

  end

  config.vm.provider :lxc do |lxc, override|
    override.vm.box = "visibilityspots/centos-6.x-puppet-3.x"
  end

  config.vm.define :puppetmaster do |puppetmaster|
    puppetmaster.vm.host_name = "puppet"
    puppetmaster.vm.synced_folder "hieradata", "/etc/hiera"
    puppetmaster.vm.synced_folder "puppet", "/etc/puppet", type: "rsync",
	    rsync__exclude: "ssl .git puppet.conf"

    puppetmaster.vm.provider :lxc do |lxc|
      lxc.container_name = 'dev-puppetmaster'
    end

    puppetmaster.vm.provision "shell", path: "scripts/puppetmaster.sh"

  end

  config.vm.define :client do |client|
    client.vm.host_name = "client"
    client.vm.provision "puppet_server" do |puppet|
      default_env = 'production'
      ext_env = ENV['VAGRANT_PUPPET_ENV']
      env = ext_env ? ext_env : puppet_env
      puppet.puppet_server = "puppet"
      puppet.options = ["--environment", "#{env}", "--test"]
    end
    client.vm.provider :lxc do |lxc|
      lxc.container_name = 'dev-client'
    end
  end

end
