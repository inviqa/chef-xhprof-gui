# General settings

default[:xhprof][:db][:database] = "xhprof"
default[:xhprof][:db][:username] = "xhprof"

::Chef::Node.send(:include, Opscode::OpenSSL::Password)

default_unless[:xhprof][:db][:password] = secure_password
