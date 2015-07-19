# Description

Installs and configures XHProf and a XHGui by Paul Reinheimer. This can be used to profile your PHP application during development and is lightweight enough to be used in production for live profiling of request samples.

[![Build Status](https://secure.travis-ci.org/inviqa/chef-xhprof-gui.png?branch=master)](http://travis-ci.org/inviqa/chef-xhprof-gui)

# Requirements

Chef 0.10.0 or higher required (for Chef environment use).

## Platform

* Debian, Ubuntu
* CentOS, Red Hat, Fedora

## Cookbooks

The following Opscode cookbooks are dependencies:

* php
* chef-php-extra
* git
* mysql
* database
* apache2

## Chef-Solo

If your using this cookbook with chef-solo you will need to define a `[:mysql][:server_root_password]` as this value will be re-generated each time chef is executed. Chef-solo does not have any storage mechanism for the attribute so it will be generated as new each time.

# Attributes

* `node["xhprof"]["db"]["database"]` = The name of the database used to store profiling data, defaults to `xhprof`.
* `node["xhprof"]["db"]["username"]` = The user that can connect to the database, defaults to `xhprof`.
* `node["xhprof"]["db"]["password"]` = The password to connect to the database, if left empty a secure password will be generated.
* `node["xhprof"]["install_path"]` = The path on the system where the XHGui code will be installed, defaults to `/opt/xhprof`.
* `node["xhprof"]["hostname"]` = "The hostname at which you can access the XHGui, defaults to `xhprof`."
* `node["xhprof"]["servername"]` = "The name of the server that is generating the profiling data, defaults to `myserver`."
* `node["xhprof"]["namespace"]` = "The namespace for the application being profiled, defaults to `myapp`."
* `node["xhprof"]["serializer"]` = "Method used to serialize data. MySQL/MySQLi/PDO ONLY Switch to JSON for better performance and support for larger profiler data sets. WARNING: Will break with existing profile data, you will need to TRUNCATE the profile data table."
* `node["xhprof"]["control_ips"]` = "IP address that are granted access to XHGui, defaults to `"localhost"` and IP V6 `"::1"`, you'll want to add your own IP. If you wish to disable this restriction set the value as `false`."
* `node["xhprof"]["alias_fqdn"]` = "If true, the node's fully qualified domain name will be added as an alias to the virtual host in apache. Default is `true`. Set to `false` if your FQDN is being used for another virtual host."

# Recipes

## default

## xhprof

Installs XHProf using PECL.

## xhgui

Installs and configures XHGui from [GitHub](https://github.com/preinheimer/xhprof) and sets up a MySql database to store data from profile runs. An apache vhost is also created to allow you to view the test run data on the server. The XHGui interface is protected by IP address. You will need to add your IP address to `node["xhprof"]["control_ips"]` in order to access the data.

# Usage

Add the following configuration line to your Apache vhost configuration or to .htaccess file:

    php_value auto_prepend_file “/opt/xhprof/external/header.php”
    php_value auto_append_file “/opt/xhprof/external/footer.php”
    
This will allow you to run the profiler on a request by adding the following params to a request `?_profile=1`.

# License and Author

Author:: Alistair Stead (alistair@inviqa.com)

Copyright 2012, Inviqa

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

