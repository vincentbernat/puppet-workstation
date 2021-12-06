class desktop::emacs {

  package { 'emacs':    ensure => installed } ->
  package { 'emacs-el': ensure => installed } ->

  # I do not like what many Debian packages do on start. That's not
  # needed. Most of the time, autoloading works just fine.
  file { "/etc/emacs/site-start.d":
    ensure  => directory,
    purge   => true,
    recurse => true
  }

  # The ones on MELPA stable are not totally up-to-date
  package { 'elpa-debian-el':   ensure => installed, require => Package['emacs'] }
  package { 'elpa-dpkg-dev-el': ensure => installed, require => Package['emacs'] }

  # Various related tools
  package { 'fortune-mod':      ensure => installed }
  package { 'gpgsm':            ensure => installed }
  package { 'zbar-tools':       ensure => installed }

}
