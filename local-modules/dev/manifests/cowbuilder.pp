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
  file { "/etc/pbuilder/hooks/B90lintian":
    ensure  => link,
    target  => "/usr/share/doc/pbuilder/examples/B90lintian",
    require => Package["cowbuilder"],
  }
  file { "/etc/pbuilder/hooks/B20autopkgtest":
    ensure  => link,
    target  => "/usr/share/doc/pbuilder/examples/B20autopkgtest",
    require => Package["cowbuilder"],
  }
  file { "/etc/pbuilder/hooks/D80no-man-db-rebuild":
    ensure  => link,
    target  => "/usr/share/doc/pbuilder/examples/D80no-man-db-rebuild",
    require => Package["cowbuilder"],
  }

}
