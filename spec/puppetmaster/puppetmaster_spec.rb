require 'spec_helper'

# POSTGRESQL
describe package('postgresql') do
  it { should be_installed }
end

describe service('postgresql') do
  it { should be_enabled }
  it { should be_running }
end

describe port(5432) do
  it { should be_listening }
end

# PUPPET
describe package('puppet') do
  it { should be_installed }
end

# PUPPETDB
describe package('puppetdb') do
  it { should be_installed }
end

describe service('puppetdb') do
  it { should be_enabled }
  it { should be_running }
end

describe port(8081) do
  it { should be_listening }
end

# PUPPETSERVER
describe package('puppetserver') do
  it { should be_installed }
end

describe service('puppetserver') do
  it { should be_enabled }
  it { should be_running }
end

describe port(8140) do
  it { should be_listening }
end

