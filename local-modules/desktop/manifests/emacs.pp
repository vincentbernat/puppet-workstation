class desktop::emacs {

  package { "emacs24": ensure => installed } ->
  package { "emacs24-el": ensure => installed }

  package { "debian-el": ensure => installed, require => Package["emacs24"] }
  package { "dpkg-dev-el": ensure => installed, require => Package["emacs24"] }
  package { "fortune-mod": ensure => installed }

}
