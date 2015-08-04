require_relative '../spec_helper.rb'

# PUPPET
describe package('puppet') do
  it { should be_installed }
end

describe command('puppet agent --test --server puppet') do
  its(:stdout) { should contain('Notice: Finished catalog run in') }
end

# HUBOT
describe package('hubot') do
  it { should be_installed }
end

describe service('hubot') do
  it { should be_running }
end
