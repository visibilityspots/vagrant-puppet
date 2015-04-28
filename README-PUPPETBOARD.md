# Puppetboard POC

This branch is used to set up a puppetboard proof of concept

## Setup

```bash
$ git clone git@github.com:visibilityspots/vagrant-puppet.git
$ git checkout puppetboard
$ git clean -d -f -f
$ git submodule update --init --recursive
```

## Usage

Once you have setted up the git environment you can use vagrant to spin up the puppetmaster:

```bash
$ vagrant up puppetmaster
$ vagrant provision puppetmaster
```

You should now be able to surf to http://puppet/puppetboard to see the last provisioned puppet run.

To spin up a client and view those reports:

```bash
$ vagrant up client
```
