class nginx {
  package {
    'nginx':
    ensure => present,
    require => Exec['update']
  }

  file {
    'nginx config file':
    path => '/etc/nginx/sites-enabled/dev-vm',
    source => 'puppet:///modules/nginx/dev-vm.conf',
    ensure => file,
    require => Package['nginx'],
    before => Service['nginx']
  }

  service {
    'nginx':
    enable => true,
    ensure => running,
    hasrestart => true,
    hasstatus => true,
    require => Package['nginx']
  }
}