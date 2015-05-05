# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  unless Vagrant.has_plugin?("vagrant-hostmanager")
    raise 'vagrant-hostmanager is not installed!'
  end

  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true

  if File.exist?('scripts/set-proxy.sh')
    config.vm.provision "shell", path: "scripts/set-proxy.sh"
  end

  config.vm.provider :virtualbox do |virtualbox, override|
    override.vm.box = "vStone/centos-6.x-puppet.3.x"
    # override.vm.box = "vStone/centos-7.x-puppet.3.x"
    virtualbox.customize ["modifyvm", :id, "--memory", 3072]
  end

  config.vm.provider :lxc do |lxc, override|
    override.vm.box = "visibilityspots/centos-6.x-puppet-3.x"
    # override.vm.box = "visibilityspots/centos-7.x-puppet-3.x"
  end

  config.vm.define :puppetmaster do |puppetmaster|
    puppetmaster.vm.host_name = "puppet"

    puppetmaster.vm.synced_folder "hieradata", "/etc/hiera", type: "rsync",
	rsync__chown: false
    puppetmaster.vm.synced_folder "puppet/environments/production", "/etc/puppet/environments/production", type: "rsync",
	rsync__chown: false

    puppetmaster.vm.provider :lxc do |lxc|
      lxc.container_name = 'dev-puppetmaster'
    end

    puppetmaster.vm.provider :virtualbox do |virtualbox, override|
      override.vm.network "private_network", ip: "10.0.5.2"
    end

    puppetmaster.vm.provision "shell", path: "scripts/puppetmaster.sh"

  end

  config.vm.define :client do |client|
    client.vm.host_name = "client"

    client.vm.provider :lxc do |lxc|
      lxc.container_name = 'dev-client'
    end

    client.vm.provider :virtualbox do |virtualbox, override|
      override.vm.network "private_network", ip: "10.0.5.3"
    end

    client.vm.provision "puppet_server" do |puppet|
      default_env = 'production'
      ext_env = ENV['VAGRANT_PUPPET_ENV']
      env = ext_env ? ext_env : puppet_env
      puppet.puppet_server = "puppet"
      puppet.options = ["--environment", "#{env}", "--test"]
    end

  end

end
