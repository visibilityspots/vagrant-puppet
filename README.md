NOT FUNCTIONING YET

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

# NFS

This project is used to set up a an NFS server which auto provisions shares and an NFS client which mounts an auto provisioned share through puppet based on lvm volumes.

It currently only works for the virtualbox provider and NOT using the lxc provider!

## Usage

### puppetmaster

```bash
$ vagrant destroy -f
$ git checkout nfs
$ git clean -d -f -f
$ git submodule update --init --recursive
$ vagrant up puppetmaster --provider=virtualbox
```

### NFS server
```bash
$ vagrant up node01 --provider virtualbox
```

### NFS client
```bash
$ vagrant up node02 --provider virtualbox
```

## Test

### serverspec
```bash
$ rake spec
```

### manual
```bash
$ vagrant ssh node01
$ showmount -e localhost
Export list for localhost:
/data 10.0.5.0/24
```

```bash
$ vagrant ssh node02
$ df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/mapper/VolGroupOS-lv_root
                      6.7G  653M  5.7G  11% /
tmpfs                 1.5G     0  1.5G   0% /dev/shm
/dev/sda1              93M   24M   65M  27% /boot
vagrant               145G   95G   51G  66% /vagrant
10.0.5.3:/data        976M  1.0M  924M   1% /data
```

As you could see on the node01 and node02 boxes a /data directory has been shared by node01 the NFS server based on a logical lvm volume on it. This share on his turn is mounted on the node02.
