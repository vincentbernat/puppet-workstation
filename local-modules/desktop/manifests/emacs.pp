class desktop::emacs {

  # Fetched from Nix now.

  # I do not like what many Debian packages do on start. That's not
  # needed. Most of the time, autoloading works just fine.
  file { "/etc/emacs/site-start.d":
    ensure  => directory,
    purge   => true,
    recurse => true
  }

  # Various related tools
  package { 'fortune-mod':      ensure => installed }
  package { 'gpgsm':            ensure => installed }
  package { 'zbar-tools':       ensure => installed }

}
