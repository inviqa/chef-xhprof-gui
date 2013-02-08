maintainer       "Alistair Stead"
maintainer_email "alistair.stead@inviqa.com"
license          "Apache 2.0"
description      "Installs/Configures XHProf XHGui"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

depends "php", "= 1.1.8"
depends "chef-php-extra"
depends "git", "= 1.0.0"
depends "mysql", "= 1.2.6"
depends "database", "> 1.2.0"
depends "apache2", "= 1.1.12"
depends "chef-xhprof-gui"

%w{ ubuntu, debian, centos, fedora }.each do |os|
  supports os
end

recipe "chef-xhprof-gui", "Install and configure XHProf and XHGui by Paul Reinheimer"
recipe "chef-xhprof-gui::xhprof", "Install and configure XHProf"
recipe "chef-xhprof-gui::xhgui", "Install and configure XHGui by Paul Reinheimer with MySql database and Apache vhost"
