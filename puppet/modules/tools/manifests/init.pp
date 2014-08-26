class tools {
  package {
    [
    'mc',
    'htop',
    'nmap',
    'build-essential',
    'checkinstall',
    'curl',
    'python-software-properties',
    'lftp',
    'libssl0.9.8'
    ]:
    ensure => present,
    require => Exec['update']
  }

  exec {
    'create www folder':
    command => 'mkdir /www; chmod 777 /www',
    creates => '/www',
    before => Exec['update']
  }
}