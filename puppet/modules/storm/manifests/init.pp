class storm {

  archive { 'apache-storm':
    ensure => present,
    url    => 'http://mirrors.muzzy.org.uk/apache/storm/apache-storm-0.9.5/apache-storm-0.9.5.tar.gz',
    target => '/opt',
    username => 'root',
    checksum => false
  }

}