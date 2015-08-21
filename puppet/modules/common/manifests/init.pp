# == Class: baseconfig
#
# Performs initial configuration tasks for all Vagrant boxes.
#
class common {
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update';
  }

  host {
    'zoo-1':
      ip => '192.168.250.50';

    'storm-worker-1':
      ip => '192.168.250.201';

    'storm-worker-2':
      ip => '192.168.250.202';
  }

  file {
    '/home/vagrant/.bashrc':
      owner => 'vagrant',
      group => 'vagrant',
      mode  => '0644',
      source => 'puppet:///modules/common/bashrc';
  }
}