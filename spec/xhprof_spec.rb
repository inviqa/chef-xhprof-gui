require 'chefspec'

describe 'chef-xhprof-gui::xhprof' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'chef-xhprof-gui::xhprof' }
  it 'should do something' do
    pending 'Your recipe examples go here.'
  end
end
