# Vagrant puppet

The idea is to have a basic puppetmaster/client setup running with [puppetserver](https://docs.puppetlabs.com/puppetserver/latest/services_master_puppetserver.html) and [puppetdb](http://docs.puppetlabs.com/puppetdb/latest/) in the master branch.

That way I could create branches based on this master branch for little proof of concepts like for example an ELK stack.

Virtualization of the machines should be hybrid for both virtualbox and lxc containers depending on the --provider parameter. Default this would be virtualbox.

## OS & Virtualization


Based on CentOS I tested both centos 6.x and 7.x using the virtualbox and lxc provider. The boxes used are:

CentOS 6.x

* lxc: [visibilityspots/centos-6.x-puppet-3.x](https://atlas.hashicorp.com/visibilityspots/boxes/centos-6.x-puppet-3.x)
* virtualbox: [vstone/centos-6.x-puppet.3.x](https://atlas.hashicorp.com/vStone/boxes/centos-6.x-puppet.3.x)

CentOS 7.x

* lxc: [visibilityspots/centos-7.x-puppet-3.x](https://atlas.hashicorp.com/visibilityspots/boxes/centos-7.x-puppet-3.x)
* virtualbox: [vstone/centos-7.x-puppet.3.x](https://atlas.hashicorp.com/vStone/boxes/centos-7.x-puppet.3.x)

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

### Shared folders

To have the ability to change the configuration on your local machine using your favorite editor I configured shared folders for the hiera data and puppet-modules in the production environment through rsync. I had to use the rsync provider since the lxc provider doesn't support the ownership/group parameters of the default shared folders of vagrant.

Adding an extra module to the modules directory or changing hiera data on your local machine which you want to be synced to the VM is rather easy. You adapt the hiera yaml file or clone the module to the puppet/environments/production/modules/ directory and perform a manual [vagrant rsync](http://docs.vagrantup.com/v2/cli/rsync.html).

You could instead of manually sync your changes every now and then also enable the [rsync-auto](http://docs.vagrantupcom/v2/cli/rsync-auto.html) daemon.

### Serverspec

I wrote some small tests using [serverspec](http://serverspec.org) to test if the functionality of the different machines is working as it supposed to be.

To benefit those tests you could install the serverspec gem and run a rake command:

```bash
$ gem install serverspec
$ rake spec
```

# ELASTICSEARCH

This project is used to set up an elastic search cluster with one instance and 2 nodes as a proof of concept.

## Usage

### puppetmaster

```bash
$ vagrant destroy -f
$ git checkout elasticsearch
$ git clean -d -f -f
$ git submodule update --init --recursive
$ vagrant up puppetmaster
```

### client

```bash
$ vagrant up node01
$ vagrant up node02
```

## Test

### serverspec
```bash
$ rake spec
```

### manually

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
