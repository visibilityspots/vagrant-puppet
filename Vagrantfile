# -*- mode: ruby -*-
# vi: set ft=ruby :
VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  unless Vagrant.has_plugin?("vagrant-hostmanager")
    raise 'vagrant-hostmanager plugin is not installed!'
  end

  if Vagrant.has_plugin?("vagrant-hostmanager")
    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
  end

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

  if File.exist?('scripts/set-proxy.sh')
    config.vm.provision "shell", path: "scripts/set-proxy.sh"
  end

  config.vm.provider :virtualbox do |virtualbox, override|
    override.vm.box = "vStone/centos-6.x-puppet.3.x"
  end

  config.vm.provider :lxc do |lxc, override|
    override.vm.box = "visibilityspots/centos-6.x-puppet-3.x"
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
      virtualbox.customize ["modifyvm", :id, "--memory", 3072]
    end
    puppetmaster.vm.provision "shell", path: "scripts/puppetmaster.sh"
  end

  config.vm.define :node01 do |node01|
    node01.vm.host_name = "node01"

    node01.vm.provider :lxc do |lxc|
      lxc.container_name = 'dev-node01'
    end

    node01.vm.provider :virtualbox do |virtualbox, override|
      override.vm.network "private_network", ip: "10.0.5.3"
    end

    node01.vm.provision "puppet_server" do |puppet|
      default_env = 'production'
      ext_env = ENV['VAGRANT_PUPPET_ENV']
      env = ext_env ? ext_env : puppet_env
      puppet.puppet_server = "puppet"
      puppet.options = ["--environment", "#{env}", "--test"]
    end

  end

  config.vm.define :node02 do |node02|
    node02.vm.host_name = "node02"

    node02.vm.provider :lxc do |lxc|
      lxc.container_name = 'dev-node02'
    end

    node02.vm.provider :virtualbox do |virtualbox, override|
      override.vm.network "private_network", ip: "10.0.5.4"
    end

    node02.vm.provision "puppet_server" do |puppet|
      default_env = 'production'
      ext_env = ENV['VAGRANT_PUPPET_ENV']
      env = ext_env ? ext_env : default_env
      puppet.puppet_server = "puppet"
      puppet.options = ["--environment", "#{env}", "--test"]
    end
  end

end
