class phpmyadmin {
  file {
    'pma copy config':
    path => '/etc/nginx/sites-enabled/phpmyadmin',
    source => 'puppet:///modules/phpmyadmin/phpmyadmin.conf',
    ensure => file,
    require => [Package['nginx'], Package['php5']],
    before => [Service['nginx'], Service['php5-fpm']]
  }

  exec {
    'pma download':
    command => 'wget http://downloads.sourceforge.net/project/phpmyadmin/phpMyAdmin/4.2.2/phpMyAdmin-4.2.2-all-languages.tar.gz',
    cwd => '/tmp',
    creates => '/tmp/phpMyAdmin-4.2.2-all-languages.tar.gz'
  }

  exec {
    'pma extract':
    command => 'tar -xvzf phpMyAdmin-4.2.2-all-languages.tar.gz',
    cwd => '/tmp',
    creates => '/tmp/phpMyAdmin-4.2.2-all-languages',
    require => Exec['pma download']
  }

  exec {
    'pma move':
    command => 'mv /tmp/phpMyAdmin-4.2.2-all-languages /opt/phpmyadmin',
    creates => '/opt/phpmyadmin',
    require => [Exec['pma extract'], File['pma copy config']]
  }
}