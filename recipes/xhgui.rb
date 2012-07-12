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

include_recipe "git"
include_recipe "mysql::server"
include_recipe "database"

directory "/opt/xhprof" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

git "/opt/xhprof" do
  repository "git://github.com/preinheimer/xhprof.git"
  revision "master"
  action :sync
end

mysql_database "xhprof" do
  connection ({:host => "localhost", :username => "root", :password => node['mysql']['server_root_password']})
  action :create
end

grants_path = value_for_platform(
  ["centos", "redhat", "suse", "fedora" ] => {
    "default" => "/etc/xhprof-grants.sql"
  },
  "default" => "/etc/mysql/xhprof-grants.sql"
)

unless File.exists?(grants_path)
  template "/etc/mysql/xhprof-grants.sql" do
    path grants_path
    source "xhprof-grants.sql.erb"
    owner "root"
    group "root"
    mode "0600"
    variables(:database => node[:xhprof][:db])
  end

  execute "mysql-install-xhprof-privileges" do
      command "/usr/bin/mysql -u root #{node['mysql']['server_root_password'].empty? ? '' : '-p' }#{node['mysql']['server_root_password']} < #{grants_path}"
      action :run
  end
end

