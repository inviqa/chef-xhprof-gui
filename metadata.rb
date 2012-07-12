maintainer       "Alistair Stead"
maintainer_email "alistair.stead@inviqa.com"
license          "Apache 2.0"
description      "Installs/Configures XHProf XHGui"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

depends "php"
depends "git"
depends "mysql"
depends "database"

%w{ ubuntu }.each do |os|
  supports os
end

recipe "chef-xhprof-gui", "Install and configure XHProf and XHGui by Paul Reinheimer"
