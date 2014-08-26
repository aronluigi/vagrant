class beanstalkd {
  package {
    'beanstalkd':
      ensure => present,
      require => Package['php5']
  }

  service {
    'beanstalkd':
      ensure => running,
      require => Package['beanstalkd']
  }
}