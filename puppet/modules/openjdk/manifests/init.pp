class openjdk {
  package {
    'openjdk-7-jdk':
    ensure => present,
    require => Exec['update']
  }
}