class base::packages {

  $packages = hiera_array('packages', [])
  package { $packages:
    ensure  => present,
  }

}