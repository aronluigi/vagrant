class grunt {
  exec {
    'install grunt':
    command => 'npm install -g grunt-cli',
    require => Package['nodejs']
  }

  exec {
    'grunt update npm':
    command => 'npm update',
    require => Exec['install grunt']
  }
}