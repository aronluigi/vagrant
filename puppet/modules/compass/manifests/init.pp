class compass {
  package {
    ['ruby','rubygems']:
    ensure => present,
    require => Exec['update']
  }

  package {
    ['sass', 'compass', 'bootstrap-sass']:
    provider => 'gem',
    ensure => 'installed',
    require => [Package['ruby'], Package['rubygems']]
  }

}