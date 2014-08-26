class mongodb {
  package {
    'mongodb':
    ensure => present,
    require => Exec['update']
  }

  exec {
    'pear update-channels':
    command => 'pear update-channels; pear upgrade;',
    require => Package['php-pear']
  }

  exec { 'mongo install':
    command => "/usr/bin/pecl install -f mongo",
    require => [
      Package['php-pear'],
      Package['mongodb'],
      Service['php5-fpm'],
      Service['nginx'],
      Exec['pear update-channels']
    ],
    unless => '/usr/bin/pecl info mongo'
  }

  service {
    'mongodb':
    enable => true,
    ensure => running,
    require => Exec['mongo install']
  }

  file {
    'mongo copy php config':
    path => '/etc/php5/fpm/conf.d/mongo.ini',
    source => 'puppet:///modules/mongodb/mongo.ini',
    ensure => file,
    require => [Package['nginx'], Package['php5'], Exec['mongo install']],
    before => Exec['mongo service refres']
  }

  exec {
    'mongo service refres':
    command => 'sleep 20; service nginx restart; service php5-fpm restart; sleep 15;',
    require => [Exec['mongo install'], Service['mongodb'], File['mongo copy php config']]
  }
}