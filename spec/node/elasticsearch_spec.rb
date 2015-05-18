require_relative '../spec_helper.rb'

# ELASTICSEARCH
describe package('elasticsearch') do
  it { should be_installed }
end

describe service('elasticsearch-es-01') do
  it { should be_enabled }
  it { should be_running }
end

describe port(9200) do
  it { should be_listening }
end

describe command('curl -XGET \'http://localhost:9200/_cluster/health?pretty=true\'') do
  its(:stdout) { should contain('"status" : "green"') }
end
