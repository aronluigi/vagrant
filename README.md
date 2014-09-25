Vagrant - Ubuntu 12.04 LTS - Development Virtual Machine
=======
A virtual machine with everything you need!

Recommended System Requirements
-----------

* VirtualBox
* Vagrant
* 8GB Ram +
* x64 Quad Core CPU
* SSD HDD

If you have an x86 system than change the system version in the "Vagrantfile"

Documentation
-----------

* [Vagrant documentation](https://docs.vagrantup.com/v2/getting-started/)
* [VirtualBox documentation](https://www.virtualbox.org/wiki/Documentation)

What's inside the box?
-----------

* PHP5-FPM - with a lot of extensions
* Nginx
* MySQL
* ElasticSearch - with head, inquisitor and marvel
* CouchBase
* Grunt
* Memcache
* MongoDB
* NodeJS & npm-check-updates
* Beanstalkd
* Compass Sass
* Compass Sass bootstrap
* OpenJDK 7
* PhpMyAdmin
* git & git-flow
* Jenkins

Nginx will auto load any .conf file under the path "data\PROJECT\server_config".

MySQL user: root,
MySQL pass: root