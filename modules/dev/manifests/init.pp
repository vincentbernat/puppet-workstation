class dev {

  package { "build-essential": ensure => installed }
  package { "dpkg-dev": ensure => installed }
  package { "ipython": ensure => installed }

  package { "nodejs": ensure => installed } ->
  package { "nodejs-legacy": ensure => installed }

  package { "make": ensure => installed }
  package { "pkg-config": ensure => installed }
  package { "autoconf": ensure => installed }
  package { "automake": ensure => installed }
  package { "libtool": ensure => installed }

}
