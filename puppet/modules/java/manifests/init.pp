
class java {

  file { '/var/local/oracle-java8-installer.preseed':
    ensure  => 'present',
    content => template('java/java.preseed')
  }

  exec { 'add_java_ppa':
    command => '/usr/bin/add-apt-repository -y ppa:webupd8team/java',
    path    => '/bin:/usr/bin',
    require => Package['python-software-properties'],
    notify  => Exec['post_ppa_apt_update'],
  }

  exec { 'post_ppa_apt_update':
    command => '/usr/bin/apt-get update',
    notify  => Package['oracle-java8-installer'],
  }

  package { 'oracle-java8-installer':
    ensure       => 'present',
    responsefile => '/var/local/oracle-java8-installer.preseed',
    require      => File['/var/local/oracle-java8-installer.preseed'],
  }

  file { '/etc/profile.d/java.sh':
    content => template('java/set_java_home.sh'),
    owner   => root,
    group   => root,
    mode    => '0755',
    require => Package['oracle-java8-installer'],
  }
}