class update {
  exec {
    'update':
    command => 'apt-get update'
  }
}