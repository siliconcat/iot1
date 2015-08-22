class puppetserver::service() {

  service { 'puppetserver':
    ensure => 'running',
    enable => true
  }

}