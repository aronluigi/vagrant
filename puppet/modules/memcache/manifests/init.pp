class memcache {
  package {
    'memcached':
    ensure => present,
    require => Exec['update']
  }

  service {
    'memcached':
    enable => true,
    ensure => running,
    require => Package['memcached']
  }
}