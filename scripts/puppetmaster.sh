#!/bin/bash
[ -f /etc/puppetlabs/puppet/hiera.yaml ] || cp /vagrant/hieradata/hiera.yaml /etc/puppetlabs/puppet/hiera.yaml
[ -f /etc/puppetlabs/puppet/autosign.conf ] || cp /vagrant/puppet/autosign.conf /etc/puppetlabs/puppet/autosign.conf

## Set up the puppetmaster using a puppet apply for bootstrapping or puppet agent --test when already bootstrapped
if [ ! -d /etc/puppetlabs/puppet/ssl/public_keys ]; then
	puppet apply /etc/puppetlabs/code/environments/production/manifests/ --modulepath /etc/puppetlabs/code/environments/production/modules --ssldir /etc/puppetlabs/puppet/ssl/
else
	puppet agent --test
fi
