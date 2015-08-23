class storm {

  archive { 'apache-storm':
    ensure => present,
    url    => 'http://www.apache.org/dyn/closer.cgi/storm/apache-storm-0.9.5/apache-storm-0.9.5.tar.gz',
    target => '/opt',
  }

}