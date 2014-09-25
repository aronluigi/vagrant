class jenkins {
  exec {
    'jenkins add key':
    command => 'wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add -',
    before => Exec['update']
  }

  exec {
    'jenkins add list':
    command => "sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'",
    creates => '/etc/apt/sources.list.d/jenkins.list',
    before => Exec['update'],
    require => Exec['jenkins add key']
  }

  package {
    'jenkins':
    ensure => present,
    require => [
      Exec['update'],
      Package['build-essential'],
      Package['checkinstall'],
      Package['curl'],
      Package['python-software-properties'],
      Package['libssl0.9.8'],
      Exec['jenkins add list']
    ]
  }

  service {
    'jenkins':
    enable => true,
    ensure => running,
    hasrestart => true,
    hasstatus => true,
    require => Package['jenkins']
  }
}