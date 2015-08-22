class puppetserver {
    anchor { 'puppetserver::begin':
      notify  => Class['puppetserver::install'],
    }

    class { 'puppetserver::install':
      require => Anchor['puppetserver::begin'],
      notify  => Class['puppetserver::configure'],
    }

    class { 'puppetserver::configure':
      require => Class['puppetserver::install'],
      notify  => Class['puppetserver::service'],
    }

    class { 'puppetserver::service':
      require => Class['puppetserver::configure'],
      notify  => Anchor['puppetserver::end'],
    }

    anchor { 'puppetserver::end': }
}