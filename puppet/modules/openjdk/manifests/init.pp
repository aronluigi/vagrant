class openjdk {
  package {
    'openjdk-7-jdk':
    ensure => present,
    require => Exec['update']
  }

  exec {
    'java update alternatives':
    command => 'update-java-alternatives --set java-1.7.0-openjdk-amd64',
    require => Package['openjdk-7-jdk']
  }
}