shared_examples 'puppet::puppetdb' do
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
end
