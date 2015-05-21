# General settings

default['xhprof']['db']['database'] = "xhprof"
default['xhprof']['db']['username'] = "xhprof"
default['xhprof']['hostname'] = "xhprof"
default['xhprof']['install_path'] = "/opt/xhprof"
default['xhprof']['servername'] = 'myserver';
default['xhprof']['namespace'] = 'myapp';
default['xhprof']['serializer'] = "php"
default['xhprof']['control_ips'] = ["127.0.0.1", "::1"]
default['xhprof']['alias_fqdn'] = true

::Chef::Node.send(:include, Opscode::OpenSSL::Password)

default_unless['xhprof']['db']['password'] = secure_password
