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

  set_proxy = false
  set_proxy_env = ENV['VAGRANT_SET_PROXY']
  proxy = set_proxy_env ? set_proxy_env : set_proxy

  if proxy == 'true'
    if File.exist?('scripts/set-proxy.sh')
      config.vm.provision "shell", path: "scripts/set-proxy.sh"
    end
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

  config.vm.define :tracker do |tracker|
    tracker.vm.host_name = "tracker"
    tracker.vm.provider :lxc do |lxc|
      lxc.container_name = 'dev-tracker'
    end
    tracker.vm.provider :virtualbox do |virtualbox, override|
      override.vm.network "private_network", ip: "10.0.5.3"
    end
    tracker.vm.provision "puppet_server" do |puppet|
      default_env = 'production'
      ext_env = ENV['VAGRANT_PUPPET_ENV']
      env = ext_env ? ext_env : default_env
      puppet.puppet_server = "puppet"
      puppet.options = ["--environment", "#{env}", "--test"]
    end
  end

  config.vm.define :node do |node|
    node.vm.host_name = "node"
    node.vm.provider :lxc do |lxc|
      lxc.container_name = 'dev-node'
    end
    node.vm.provider :virtualbox do |virtualbox, override|
      override.vm.network "private_network", ip: "10.0.5.3"
    end
    node.vm.provision "puppet_server" do |puppet|
      default_env = 'production'
      ext_env = ENV['VAGRANT_PUPPET_ENV']
      env = ext_env ? ext_env : default_env
      puppet.puppet_server = "puppet"
      puppet.options = ["--environment", "#{env}", "--test"]
    end
  end

end
