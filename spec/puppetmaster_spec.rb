require 'spec_helper'

describe 'puppetmaster' do
	include_examples 'postgresql::server'
	include_examples 'puppet::puppetdb'
	include_examples 'puppet::master'
	include_examples 'puppet::client'
end
