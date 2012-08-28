require 'chefspec'

describe 'chef-xhprof-gui::xhgui' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'chef-xhprof-gui::xhgui' }
  it 'should do something' do
    pending 'Your recipe examples go here.'
  end
end
