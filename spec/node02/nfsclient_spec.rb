require 'spec_helper'

# NFS
describe package('nfs-utils') do
  it { should be_installed }
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

describe file('/etc/fstab') do
	  it { should contain '10.0.5.3:/data	/data	nfs	rw	0	0' }
end

describe command('showmount -e 10.0.5.3') do
  its(:stdout) { should contain('/data') }
end

describe command('df -h') do
  its(:stdout) { should contain('/data') }
end
