# Description

Installs and configures XHProf and a XHGui by Paul Reinheimer. This can be used to profile your PHP application during development and is lightweight enough to be used in production for live profiling of request samples.

# Requirements

Chef 0.10.0 or higher required (for Chef environment use).

## Platform

* Debian, Ubuntu
* CentOS, Red Hat, Fedora

## Cookbooks

The following Opscode cookbooks are dependencies:

* php
* git
* mysql
* database

## Chef-Solo

If your using this cookbook with chef-solo you will need to define a `[:mysql][:server_root_password]` as this value will be re-generated each time chef is executed. Chef-solo does not have any storage mechanism for the attribute so it will be generated as new each time.

# Attributes

# Recipes

## default

## xhprof

## xhgui

# Usage

Add the following configuration line to your Apache vhost configuration or to .htaccess file:

    php_value auto_prepend_file “/opt/xhprof/external/header.php”
    php_value auto_append_file “/opt/xhprof/external/footer.php”

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

