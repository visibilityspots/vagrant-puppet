shared_examples 'puppet::master' do
  describe port(8140) do
    it { should be_listening }
  end
end
