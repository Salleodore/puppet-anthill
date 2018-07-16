require 'spec_helper'
describe 'anthill_quest' do
  context 'with default values for all parameters' do
    it { should contain_class('anthill_quest') }
  end
end
