class elasticsearch {
  exec {
    'es download':
    command => 'wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.2.1.deb',
    cwd => '/tmp',
    creates => '/tmp/elasticsearch-1.2.1.deb',
    timeout => 0
  }

  package { 'es install':
    provider => dpkg,
    ensure => installed,
    source => "/tmp/elasticsearch-1.2.1.deb",
    require => [Package['memcached'], Package['openjdk-7-jdk'], Exec['java update alternatives']]
  }

  exec {
    'es head plugin':
    command => '/usr/share/elasticsearch/bin/plugin --install mobz/elasticsearch-head',
    creates => '/usr/share/elasticsearch/plugins/head',
    require => Package['es install'],
    before => Exec['es shutdown']
  }

  exec {
    'es inquisitor':
    command => '/usr/share/elasticsearch/bin/plugin --install polyfractal/elasticsearch-inquisitor',
    creates => '/usr/share/elasticsearch/plugins/inquisitor',
    require => Package['es install'],
    before => Exec['es shutdown']
  }

#  exec {
#    'es couchbase':
#    command => '/usr/share/elasticsearch/bin/plugin --install transport-couchbase -url http://packages.couchbase.com.s3.amazonaws.com/releases/elastic-search-adapter/1.2.0/elasticsearch-transport-couchbase-1.2.0.zip',
#    creates => '/usr/share/elasticsearch/plugins/transport-couchbase',
#    require => Package['es install'],
#    before => Exec['es shutdown']
#  }

  exec {
    'es marvel':
    command => '/usr/share/elasticsearch/bin/plugin --install elasticsearch/marvel/latest',
    creates => '/usr/share/elasticsearch/plugins/marvel',
    require => Package['es install'],
    before => Exec['es shutdown']
  }

  exec {
    'es shutdown':
    command => "curl -XPOST 'http://localhost:9200/_shutdown'; sleep 10",
    require => [Package['es install'], Package['curl']],
    before => Service['elasticsearch']
  }

  exec {
    'es start':
    command => "service elasticsearch start; sleep 10",
    require => [Package['es install'], Exec['es shutdown']]
  }

  service {
    'elasticsearch':
    enable => true,
    ensure => running,
    hasrestart => true,
    hasstatus => true,
    require => Package['es install']
  }
}