# Vagrant puppet showcase

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

### Bringing up a node against the puppetmaster
```bash
$ vagrant up client
```

### Using the different branches to spin up different proof of concepts

You have to checkout the branch you want to test:

```bash
$ vagrant destroy -f
$ git checkout puppetboard
$ git submodule update --init --recursive
$ vagrant up puppetmaster
$ vagrant up client
```

When going back to the master branch you will notice that the puppet/environments/production/modules is messed up with the feature branches submodules. You can easily clean this up with

```bash
$ git clean -d -f -f
```

according to the docs:

       -d
           Remove untracked directories in addition to untracked files. If an untracked directory is managed by a different Git repository, it is not removed by default. Use -f option twice if you really want to remove such a directory.

       -f, --force
           If the Git configuration variable clean.requireForce is not set to false, git clean will refuse to delete files or directories unless given -f, -n or -i. Git will refuse to delete directories with .git sub directory or file unless a second -f is given.
           This affects also git submodules where the storage area of the removed submodule under .git/modules/ is not removed until -f is given twice.

