require 'chefspec'
require 'chefspec/berkshelf'

describe 'chef-xhprof-gui::xhgui' do
  before {
    stub_command("\"/usr/bin/mysql\" -u root -e 'show databases;'").and_return('')
    stub_command('/usr/sbin/apache2 -t').and_return(true)
  }

  let (:chef_run) {
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04') do |node|
      node.set['mysql']['server_debian_password'] = 'test'
      node.set['mysql']['server_root_password'] = 'test'
      node.set['mysql']['server_repl_password'] = 'test'
      node.set['mysql']['master'] = true
      node.automatic['fqdn'] = 'foo.example.com'
    end
  }

  it 'should set fqdn as a server alias' do
    chef_run.converge(described_recipe)
    expect(chef_run).to render_file('/etc/apache2/sites-available/xhprof.conf').with_content('ServerAlias foo.example.com')
  end

  it 'should not set fqdn as a server alias' do
    chef_run.node.set['xhprof']['alias_fqdn'] = false
    chef_run.converge(described_recipe)
    expect(chef_run).to_not render_file('/etc/apache2/sites-available/xhprof.conf').with_content('ServerAlias foo.example.com')
  end
end