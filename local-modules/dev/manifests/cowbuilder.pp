class dev::cowbuilder {

  # We require /var/lib/systems to exist. It is usually a LVM
  # volume. We do not put the create to let this rule fail if it
  # doesn't exist.
  file { "/var/cache/pbuilder":
    ensure => link,
    target => "/var/lib/systems/pbuilder"
  }
  ->
  package { "cowbuilder":
    ensure => installed
  }

  file { "/etc/pbuilderrc":
    source => "puppet:///modules/dev/pbuilder/pbuilderrc",
    require => Package["cowbuilder"]
  }

  file { "/etc/pbuilder/deps":
    ensure  => directory,
    require => Package["cowbuilder"]
  }
  file { "/etc/pbuilder/deps/Packages":
    ensure  => present,
    require => Package["cowbuilder"]
  }

  file { "/etc/pbuilder/hooks":
    ensure  => directory,
    require => Package["cowbuilder"],
    recurse => true,
    purge   => true,
    source  => "puppet:///modules/dev/pbuilder/hooks"
  }

}
