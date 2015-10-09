shared_examples 'puppet::client' do
  describe package('puppet-agent') do
    it { should be_installed }
  end

  describe command('puppet agent --test --server puppet') do
    its(:stdout) { should contain('Notice: Applied catalog in') }
  end
end
