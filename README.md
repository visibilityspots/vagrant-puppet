# Vagrant puppet showcase

This still is under heavy development and not working as I wish yet.

The idea is to have a basic puppetmaster/client setup running with puppetserver/puppetdb in the master branch and creating branches for little proof of concepts like for example an ELK stack.

## Requirements

* latest virtualbox version
* (lxc configured)
* latest vagrant version
* vagrant plugins:
    vagrant-hostmanager
    vagrant-lxc

## Usage

```bash

$ git clone git@github.com:visibilityspots/vagrant-puppet.git
$ git submodule update --init
$
$ vagrant up puppetmaster

```
