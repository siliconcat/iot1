class storm {

  archive { 'apache-storm':
    ensure => present,
    url    => 'http://mirrors.muzzy.org.uk/apache/storm/apache-storm-0.9.5/apache-storm-0.9.5.tar.gz',
    target => '/opt',
    username => 'root',
    checksum => false
  }

  exec { 'chown_vagrant':
    path => ["/usr/bin/","/usr/sbin/","/bin"],
    command => 'chown -R vagrant:vagrant /opt/apache-storm',
    user => 'root',
    require => Archive['apache-storm']
  }

  file { '/opt/apache-storm/apache-storm-0.9.5/conf/storm.yaml':
    mode    => '0644',
    content => template('storm/storm.yaml.erb'),
    require => Exec['chown_vagrant']
  }


}