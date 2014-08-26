Exec {
  path => ["/usr/bin", "/usr/bin:/bin", "/bin", "/usr/sbin", "/sbin", "/usr/local/bin", "/usr/local/sbin"]
}

File { owner => 'root', group => 'root' }

include update
include tools
include openjdk
include nginx
include mysql
include memcache
include php-fpm
include mongodb
include compass
include nodjs
include grunt
include phpmyadmin
include elasticsearch
include couchbase
include beanstalkd