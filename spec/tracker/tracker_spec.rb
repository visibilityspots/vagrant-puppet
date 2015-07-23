require 'spec_helper'

# TRANSMISSION DAEMON
describe package('transmission-daemon') do
  it { should be_installed }
end

describe service('transmission-daemon') do
  it { should be_enabled }
  it { should be_running }
end

describe port(9091) do
  it { should be_listening }
end

# OPENTRACKER
describe package('opentracker') do
  it { should be_installed }
end

describe service('opentracker') do
  it { should be_enabled }
  it { should be_running }
end

describe port(6969) do
  it { should be_listening }
end


#describe command('puppet agent --test --server puppet') do
#  its(:stdout) { should contain('Notice: Finished catalog run in') }
#end
