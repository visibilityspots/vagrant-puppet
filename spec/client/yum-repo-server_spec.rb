require_relative '../spec_helper.rb'

# JETTY
describe package('jetty') do
  it { should be_installed }
end

describe service('jetty') do
  it { should be_running }
end

describe port(8888) do
  it { should be_listening }
end

# MONGODB
describe package('mongodb-org-server') do
  it { should be_installed }
end

describe service('mongod') do
  it { should be_running }
end

describe port(27017) do
  it { should be_listening }
end

# YUM-REPO-SERVER
describe package('yum-repo-server') do
  it { should be_installed }
end

# YUM-REPO-CLIENT
describe package('yum-repo-client') do
  it { should be_installed }
end

describe command('repoclient -h') do
  its(:stdout) { should contain('Creates a new empty repository on the') }
end

