class mysql {
  package {
    ['mysql-common', 'mysql-client', 'mysql-server']:
    ensure => present,
    require => [Exec['update'], Package['nginx']]
  }

  service {
    'mysql':
    enable => true,
    ensure => running,
    require => Package['mysql-server']
  }

  exec {
    'mysql-set-root-password':
    refreshonly => true,
    unless => "mysqladmin -uroot -proot status",
    command => "mysqladmin -uroot password root",
    subscribe => [Package['mysql-common'], Package['mysql-client'], Package['mysql-server']]
  }
}