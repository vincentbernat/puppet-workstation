class desktop::emacs {

  package { 'emacs':    ensure => installed } ->
  package { 'emacs-el': ensure => installed } ->
  file { "/etc/emacs/site-start.d":
    ensure => directory,
    purge  => true
  }

  package { 'elpa-debian-el':   ensure => installed, require => Package['emacs'] }
  package { 'elpa-dpkg-dev-el': ensure => installed, require => Package['emacs'] }
  package { 'fortune-mod':      ensure => installed }
  package { 'gpgsm':            ensure => installed }
  package { 'zbar-tools':       ensure => installed }

}
