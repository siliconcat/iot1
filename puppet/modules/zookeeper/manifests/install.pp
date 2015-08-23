class zookeeper::install {

  exec{'retrieve_cloudera':
    command => '/usr/bin/wget -q http://archive.cloudera.com/cdh5/one-click-install/trusty/amd64/cdh5-repository_1.0_all.deb -O /tmp/cdh5-repository_1.0_all.deb',
    creates => '/tmp/cdh5-repository_1.0_all.deb',
  }

  file {'/tmp/cdh5-repository_1.0_all.deb':
    mode => '0755',
    require => Exec['retrieve_cloudera'],
    notify => Package['cdh5-repository']
  }

  package { 'cdh5-repository':
    provider => 'dpkg',
    ensure  => 'latest',
    source => '/tmp/cdh5-repository_1.0_all.deb',
    notify => Exec['apt_get_update']
  }

  exec { 'apt_get_update':
    command => '/usr/bin/apt-get update'
  }

  package { 'zookeeper-server':
    ensure  => 'present',
    require => Exec['apt_get_update'],
  }

}