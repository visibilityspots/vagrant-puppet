# README

This project is used to set up an elastic search cluster with one instance and 2 nodes as a proof of concept.

## Usage

```bash
git clone git@github.com:visibilityspots/vagrant-puppet.git
git clean -d -f -f
git submodule update --init --recursive
```

Spin up the puppetmaster

```bash
$ vagrant up puppetmaster
$ vagrant provision puppetmaster
```

Spin up the nodes:

```
$ vagrant up node01
$ vagrant up node02
```

## test the setup

```bash
$ vagrant ssh node01
Last login: Thu Mar 19 10:24:38 2015 from 10.0.2.2
[vagrant@node01 ~]$ curl -XGET 'http://localhost:9200/_cluster/health?pretty=true'
{
  "cluster_name" : "cluster",
  "status" : "green",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
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
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 0,
  "active_shards" : 0,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 0
}
```
