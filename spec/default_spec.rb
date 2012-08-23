require 'chefspec'

describe 'chef-xhprof-gui::default' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'chef-xhprof-gui::default' }
  it 'should do something' do
    pending 'Your recipe examples go here.'
  end
end
