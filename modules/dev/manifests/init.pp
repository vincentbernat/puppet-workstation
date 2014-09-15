class dev {

  package { "build-essential": ensure => installed }
  package { "dpkg-dev": ensure => installed }
  package { "debhelper": ensure => installed }
  package { "git-buildpackage": ensure => installed }
  package { "dput-ng": ensure => installed }

  package { "nodejs": ensure => installed } ->
  package { "nodejs-legacy": ensure => installed }

  package { "make": ensure => installed }
  package { "pkg-config": ensure => installed }
  package { "autoconf": ensure => installed }
  package { "automake": ensure => installed }
  package { "libtool": ensure => installed }
  package { "gdb": ensure => installed }
  package { "valgrind": ensure => installed }
  package { "ccache": ensure => installed }

  package { "ipython": ensure => installed }
  package { "ipython3": ensure => installed }
  package { "python-all-dev": ensure => installed }
  package { "python3-all-dev": ensure => installed }
  package { "python-tox": ensure => installed }
  package { "python-nose": ensure => installed }
  package { "python3-nose": ensure => installed }
  package { "cookiecutter": ensure => installed }
  package { "python-virtualenv": ensure => installed }
  package { "python-twisted": ensure => installed }

  # Maintainers don't want to ship a correct version...
  file { "/opt/global.deb":
    source => "puppet:///modules/dev/global_6.2.10-0_amd64.deb"
  }
  ->
  package { "global":
    provider => dpkg,
    source => "/opt/global.deb",
    ensure => latest
  }

  include cowbuilder

}
