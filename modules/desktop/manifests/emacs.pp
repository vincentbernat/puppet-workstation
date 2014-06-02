class emacs {

  package { "emacs24-lucid": ensure => installed } ->
  package { "emacs24-el": ensure => installed }
  package { "emacs24": ensure => absent }

  package { "debian-el": ensure => installed, require => Package["emacs24-lucid"] }
  package { "dpkg-dev-el": ensure => installed, require => Package["emacs24-lucid"] }

}
