name             "chef-xhprof-gui"
maintainer       "Alistair Stead"
maintainer_email "alistair.stead@inviqa.com"
license          "Apache 2.0"
description      "Installs/Configures XHProf XHGui"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.4.1"

depends "php"
depends "git"
depends "mysql", "< 5.0.0"
depends "database", "> 1.3.0"
depends "apache2"

%w{ ubuntu debian centos fedora }.each do |os|
  supports os
end

recipe "chef-xhprof-gui", "Install and configure XHProf and XHGui by Paul Reinheimer"
recipe "chef-xhprof-gui::xhprof", "Install and configure XHProf"
recipe "chef-xhprof-gui::xhgui", "Install and configure XHGui by Paul Reinheimer with MySql database and Apache vhost"
