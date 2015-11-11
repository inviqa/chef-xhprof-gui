#
# Cookbook Name:: chef-xhprof-gui
# Recipe:: xhgui
#
# Copyright 2012, Alistair Stead
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

directory "/opt/xhprof" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

git node['xhprof']['install_path'] do
  repository "git://github.com/inviqa/xhprof.git"
  revision "master"
  action :sync
end

mysql_connection_info = {
  :host => node['xhprof']['db']['host'],
  :port => node['xhprof']['db']['port'],
  :username => "root",
  :password => node['mysql']['server_root_password']
}

mysql_database node['xhprof']['db']['database'] do
  connection (mysql_connection_info)
  action :create
end

mysql_database_user node['xhprof']['db']['username'] do
  connection mysql_connection_info
  password node['xhprof']['db']['password']
  database_name node['xhprof']['db']['database']
  host node['xhprof']['db']['host']
  privileges [:select,:update,:insert]
  action :grant
end

template "#{node['xhprof']['install_path']}/create_pdo.sql" do
  source "create_pdo.sql.erb"
  owner "root"
  group "root"
  mode "0600"
end

execute "mysql-install-xhprof-database" do
    command "/usr/bin/mysql #{node['xhprof']['db']['host'].empty? || node['xhprof']['db']['host'] == "localhost" ? '' : '-h ' + node['xhprof']['db']['host']} -u root #{node['mysql']['server_root_password'].empty? ? '' : '-p' }#{node['mysql']['server_root_password']} #{node['xhprof']['db']['database']} < #{node['xhprof']['install_path']}/create_pdo.sql"
    action :run
end


template "#{node['xhprof']['install_path']}/xhprof_lib/config.php" do
  source "config.php.erb"
  owner "root"
  group "root"
  mode "0644"
  variables(
    :params => node['xhprof'],
    :database => node['xhprof']['db']
  )
end

web_app node['xhprof']['hostname'] do
  server_name node['xhprof']['hostname']
  apache node['apache']
  server_aliases [node['fqdn']]
  docroot "#{node['xhprof']['install_path']}/xhprof_html"
end

# Install Graphviz for use with xhprof-gui graphs.
package "graphviz"

log " You can now access XHGui at #{node['xhprof']['hostname']} #{node['fqdn']}"
