class desktop::emacs {

  package { ['emacs24', 'emacs24-el']:
    ensure => purged
  }
  package { 'emacs':    ensure => installed } ->
  package { 'emacs-el': ensure => installed } ->
  file { "/etc/emacs/site-start.d":
    ensure => absent,
    force  => yes
  }

  package { 'elpa-debian-el':   ensure => installed, require => Package['emacs'] }
  package { 'elpa-dpkg-dev-el': ensure => installed, require => Package['emacs'] }
  package { 'fortune-mod':      ensure => installed }
  package { 'gpgsm':            ensure => installed }
  package { 'zbar-tools':       ensure => installed }

}
