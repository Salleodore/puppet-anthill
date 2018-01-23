require 'spec_helper'
describe 'anthill_market' do
  context 'with default values for all parameters' do
    it { should contain_class('anthill_market') }
  end
end
