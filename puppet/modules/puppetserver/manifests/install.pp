class puppetserver::install {

#  wget https://apt.puppetlabs.com/puppetlabs-release-pc1-trusty.deb
#  sudo dpkg -i puppetlabs-release-pc1-trusty.deb
#  sudo apt-get update

  exec{'retrieve_puppetlabs_pc1':
    command => '/usr/bin/wget -q https://apt.puppetlabs.com/puppetlabs-release-pc1-trusty.deb -O /tmp/puppetlabs-release-pc1-trusty.deb',
    creates => '/tmp/puppetlabs-release-pc1-trusty.deb',
  }

  file {'/tmp/puppetlabs-release-pc1-trusty.deb':
    mode => 0755,
    require => Exec['retrieve_puppetlabs_pc1'],
    notify => Package['puppetlabs-release-pc1']
  }

  package { 'puppetlabs-release-pc1':
    provider => 'dpkg',
    ensure  => 'latest',
    source => '/tmp/puppetlabs-release-pc1-trusty.deb',
    notify => Exec['apt_get_update']
  }

  exec { 'apt_get_update':
    command => '/usr/bin/apt-get update'
  }

  package { 'puppetserver':
    ensure  => 'latest',
    require => Exec['apt_get_update'],
  }

}