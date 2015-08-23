class zookeeper::service() {

  exec { 'zookeeper-server_init':
    path => ["/usr/bin/","/usr/sbin/","/bin"],
    command => 'sudo service zookeeper-server init',
    user => 'root'
  }

  service { 'zookeeper-server':
    ensure => 'running',
    enable => true,
    require => Exec['zookeeper-server_init']
  }

}