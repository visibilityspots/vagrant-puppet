require 'spec_helper'

# NFS
describe package('nfs-utils') do
  it { should be_installed }
end

describe service('nfs') do
  it { should be_enabled }
  it { should be_running }
end

describe port(2049) do
  it { should be_listening }
end

# RPCbind
describe package('rpcbind') do
  it { should be_installed }
end

describe service('rpcbind') do
  it { should be_enabled }
  it { should be_running }
end

describe port(111) do
  it { should be_listening }
end

# Functional test
describe command('showmount -e localhost') do
  its(:stdout) { should contain('/data') }
end
