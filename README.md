# Vagrant puppet

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

Using the [vagrant-hostmanager](https://github.com/smdahlen/vagrant-hostmanager) plugin the hosts file on your local machine as well as those on the vm's are being updated automatically with the new addresses located through vagrant. That way you could use dns names instead of ip addresses.

### Puppet

Since this is a development setup and you probably don't want to sign each certificate when bringing up a vm the [naive auto sign option](https://docs.puppetlabs.com/puppet/latest/reference/ssl_autosign.html#nave-autosigning) has been enabled. Because the used puppet-puppet module doesn't have this feature I configured the option through augeas in the puppetmaster role. This implies that every time you provision the puppetmaster the puppetserver will be restarted unfortunately.

### Shared folders

To have the ability to change the configuration on your local machine using your favorite editor I configured shared folders for the hiera data through rsync. I had to use the rsync provider since the lxc provider doesn't support the ownership/group parameters of the default shared folders of vagrant.

Adding an extra module to the modules directory on your local machine which you want to be synced to the VM is rather easy. You clone the module to the appropriate place and the perform a manual [vagrant rsync](http://docs.vagrantup.com/v2/cli/rsync.html).

When you are editing files in your hiera hierarchy you could use the [rsync-auto](http://docs.vagrantupcom/v2/cli/rsync-auto.html) daemon.

## Usage

### Initialize your local environment

```bash
$ git clone git@github.com:visibilityspots/vagrant-puppet.git
$ git clean -d -f -f
$ git submodule update --init --recursive
```

### Bringing up the puppetmaster
```bash
$ vagrant up puppetmaster
```

# ELASTICSEARCH

This project is used to set up an elastic search cluster with one instance and 2 nodes as a proof of concept.

## Usage

```
$ vagrant up node01
$ vagrant up node02
```

## Test the setup

```bash
$ vagrant ssh node01
[vagrant@node01 ~]$ curl -XGET 'http://localhost:9200/_cluster/health?pretty=true'
{
  "cluster_name" : "cluster",
  "status" : "green",
  "timed_out" : false,
  "number_of_nodes" : 2,
  "number_of_data_nodes" : 2,
  "active_primary_shards" : 0,
  "active_shards" : 0,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 0
}

```

```bash
$vagrant ssh node02
[vagrant@node02 ~]$ curl -XGET 'http://localhost:9200/_cluster/health?pretty=true'
{
  "cluster_name" : "cluster",
  "status" : "green",
  "timed_out" : false,
  "number_of_nodes" : 2,
  "number_of_data_nodes" : 2,
  "active_primary_shards" : 0,
  "active_shards" : 0,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 0
}
```
