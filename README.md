# Vagrant puppet showcase

This still is under heavy development and not working as I wish yet.

The idea is to have a basic puppetmaster/client setup running with puppetserver/puppetdb in the master branch and creating branches for little proof of concepts like for example an ELK stack.

Virtualization of the machines should be hybrid for both virtualbox and lxc containers depending on the --provider parameter. Default this would be virtualbox.

## Requirements

* [vagrant](https://www.vagrantup.com/) installed
    - Vagrant 1.7.2

* vagrant plugins ($ vagrant plugin install vagrant-x):
    - [vagrant-hostmanager](https://github.com/smdahlen/vagrant-hostmanager)

* [virtualbox](https://www.virtualbox.org/):
    - virtualbox 4.3.26-3
    - virtualbox-ext-oracle 4.3.26-5

* [lxc](https://github.com/fgrehm/vagrant-lxc/wiki) configured
   - [vagrant-lxc](https://github.com/fgrehm/vagrant-lxc) plugin

## Setup


### Networking

If you use virtualbox as virtualization solution the ip addresses of the nodes are staticly been configured in the Vagrantfile. Adopt to your needs if necessary.

For the lxc provider vagrant will locate an ip address provided by the dhcp service you have configured for your lxc setup.

Using the [vagrant-hostmanager]() plugin the hosts file on your local machine as those on the vm's are being updated automatically with the new addresses located through vagrant. That way you could use dns names instead of ip addresses.

### Puppet

Since this is a development setup and you probably don't want to sign each certificate when bringing up a vm the [auto sign option](https://docs.puppetlabs.com/puppet/latest/reference/ssl_autosign.html#nave-autosigning) has been enabled. Because the used puppet-puppet module doesn't have this feature I configured the option through augeas in the puppetmaster role. This implies that every time you provision the puppetmaster the puppetserver will be restarted unfortunately.

### Shared folders

To have the ability to change the configuration on your local machine using your favorite editor I configured shared folders for the hiera data through rsync. To enable this functionality you have to use the [rsync-auto](http://docs.vagrantupcom/v2/cli/rsync-auto.html) daemon.

Take care this causes some breaking issues for the moment. [Issues section](#Issues)

## Usage

### Initialize your local environment

```bash
$ git clone git@github.com:visibilityspots/vagrant-puppet.git
$ git submodule update --init
```

### Bringing up the puppetmaster
```bash
$ vagrant up puppetmaster
```

### Bringing up a node against the puppetmaster
```bash
$ vagrant up client
```

## Issues

Once you enabled the rsync-auto daemon the /etc/puppet/ssl directory will be cleaned which crashes the puppetmaster. Reallocating the ssl directory configuration wise doesn't solve the issue neither does the exclude option of the rsync feature.
