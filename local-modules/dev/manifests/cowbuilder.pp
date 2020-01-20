class dev::cowbuilder {

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
    mode    => '0755',
    source  => "puppet:///modules/dev/pbuilder/hooks"
  }

}
