require_relative '../spec_helper.rb'

# PUPPETBOARD
describe package('httpd') do
  it { should be_installed }
end

describe service('httpd') do
  it { should be_running }
end

describe command('curl -s --noproxy \'*\' http://localhost/puppetboard/ | grep https://github.com/puppet-community/puppetboard') do
	  its(:stdout) { should contain('puppetboard') }
end
