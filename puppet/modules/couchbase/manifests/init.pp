class couchbase {
  exec {
    'cb download':
      command => 'wget http://packages.couchbase.com/releases/2.2.0/couchbase-server-community_2.2.0_x86_64.deb',
      cwd => '/tmp',
      creates => '/tmp/couchbase-server-community_2.2.0_x86_64.deb',
      timeout => 0
  }

  package {
    'cb install':
      provider => dpkg,
      ensure => installed,
      source => '/tmp/couchbase-server-community_2.2.0_x86_64.deb',
      require => [Package['libssl0.9.8'], Exec['cb download']]
  }
}