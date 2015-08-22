# == Class: baseconfig
#
# Performs initial configuration tasks for all Vagrant boxes.
#
class base {
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update';
  }

  host {
    'puppet':
      ip => '192.168.250.2';

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
      source => 'puppet:///modules/base/bashrc';
  }
}