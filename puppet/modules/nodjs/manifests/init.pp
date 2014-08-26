class nodjs {
  exec {
    'nodejs add repo':
    command => 'add-apt-repository ppa:chris-lea/node.js; apt-get update',
    require => Package['python-software-properties']
  }

  package {
    'nodejs':
    ensure => present,
    require => [Exec['update'], Exec['nodejs add repo']]
  }

  exec {
    'nodejs forever':
    command => 'npm install -g forever',
    require => Package['nodejs']
  }
}