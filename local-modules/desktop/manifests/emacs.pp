class desktop::emacs {

  package { ["emacs24", "emacs24-el"]:
    ensure => purged
  }
  package { "emacs25": ensure => installed } ->
  package { "emacs25-el": ensure => installed }

  package { "debian-el": ensure => installed, require => Package["emacs25"] }
  package { "dpkg-dev-el": ensure => installed, require => Package["emacs25"] }
  package { "fortune-mod": ensure => installed }

}
