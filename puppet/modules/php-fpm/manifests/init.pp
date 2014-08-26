class php-fpm {
  exec {
    'php add repo':
    command => 'add-apt-repository ppa:ondrej/php5; apt-get update;',
    require => Package['python-software-properties']
  }

  package {
    [
    'php5',
    'php-pear',
    'php5-cli',
    'php5-common',
    'php5-curl',
    'php5-dev',
    'php5-fpm',
    'php5-gd',
    'php5-imagick',
    'php5-mcrypt',
    'php5-memcache',
    'php5-memcached',
    'php5-mysql',
    'php5-pgsql',
    'php5-sqlite',
    #'php5-suhosin',
    'php5-xdebug',
    'php5-xsl',
    'php5-json',
    'php5-tidy',
    'php5-intl',
    #'php5-sasl',
    'php-soap'
    ]:
    ensure => present,
    require => [
      Exec['update'],
      Package['nginx'],
      Package['mysql-server'],
      Package['memcached'],
      Exec['php add repo']
    ]
  }

  exec {
    'xdebug settup':
    command => 'echo "xdebug.remote_enable = on" >> /etc/php5/fpm/conf.d/xdebug.ini; echo "xdebug.remote_connect_back = on" >> /etc/php5/fpm/conf.d/xdebug.ini; echo "" > /tmp/xdebug.lock;',
    creates => '/tmp/xdebug.lock',
    require => [Package['php5-xdebug'], Package['php5']],
    notify => Service['php5-fpm']
  }

  service { 'php5-fpm':
    ensure => running,
    require => Package['php5-fpm']
  }

  exec {
    'php stop apache and start nginx':
    command => 'service apache2 stop; ervice nginx start; service php5-fpm restart',
    require => [Package['php5-fpm'], Package['nginx'], Service['php5-fpm'], Service['nginx']]
  }
}