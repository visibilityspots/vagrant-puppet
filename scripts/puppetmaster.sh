#!/bin/bash

[ -f /etc/puppet/hiera.yaml ] || cp /vagrant/hieradata/hiera.yaml /etc/puppet/hiera.yaml

## Set up the puppetmaster using a puppet apply for bootstrapping or puppet agent --test when already bootstrapped

if [ ! -d /etc/puppet/ssl/public_keys ]; then
	puppet apply /etc/puppet/environments/production/manifests/ --modulepath /etc/puppet/environments/production/modules
else
	puppet agent --test
fi
