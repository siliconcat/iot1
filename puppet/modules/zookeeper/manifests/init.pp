class zookeeper {
  anchor { 'zookeeper::begin':
    notify  => Class['zookeeper::install'],
  }

  class { 'zookeeper::install':
    require => Anchor['zookeeper::begin'],
    notify  => Class['zookeeper::configure'],
  }

  class { 'zookeeper::configure':
    require => Class['zookeeper::install'],
    notify  => Class['zookeeper::service'],
  }

  class { 'zookeeper::service':
    require => Class['zookeeper::configure'],
    notify  => Anchor['zookeeper::end'],
  }

  anchor { 'zookeeper::end': }
}