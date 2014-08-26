class compass {
  package {
    ['ruby','rubygems']:
    ensure => present,
    require => Exec['update']
  }

  exec {
    'compass install':
    command => 'gem update --system; gem install compass;',
    path => ['/opt/vagrant_ruby/bin', '/usr/bin/gem'],
    require => [Package['ruby'], Package['rubygems']]
  }

  exec {
    'compass bootstrap install':
    command => 'gem install bootstrap-sass',
    path => ['/opt/vagrant_ruby/bin', '/usr/bin/gem'],
    require => [Package['ruby'], Package['rubygems'], Exec['compass install']]
  }
}