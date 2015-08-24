class storm_nimbus {

  file {'/var/log/storm':
    ensure => 'directory'
  }

  daemontools::service {'storm-nimbus':
    ensure  => running,
    command => '/opt/apache-storm/apache-storm-0.9.5/bin/storm nimbus',
    logpath => '/var/log/storm/nimbus',
    require => File['/var/log/storm']
  }

  daemontools::service {'storm-ui':
    ensure  => running,
    command => '/opt/apache-storm/apache-storm-0.9.5/bin/storm ui',
    logpath => '/var/log/storm/ui',
    require => File['/var/log/storm']
  }

}