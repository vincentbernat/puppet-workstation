class dev {

  package { 'build-essential':  ensure => installed }
  package { 'dpkg-dev':         ensure => installed }
  package { 'debhelper':        ensure => installed }
  package { 'git-buildpackage': ensure => installed }
  package { 'dput-ng':          ensure => installed }

  package { 'nodejs': ensure => installed }

  package { 'make':            ensure => installed }
  package { 'pkg-config':      ensure => installed }
  package { 'autoconf':        ensure => installed }
  package { 'automake':        ensure => installed }
  package { 'libtool':         ensure => installed }
  package { 'gdb':             ensure => installed }
  package { 'valgrind':        ensure => installed }
  package { 'ccache':          ensure => installed }
  package { 'global':          ensure => installed }
  package { 'bear':            ensure => installed }

  package { 'ipython':           ensure => installed }
  package { 'ipython3':          ensure => installed }
  package { 'python-all-dev':    ensure => installed }
  package { 'python3-all-dev':   ensure => installed }
  package { 'python-tox':        ensure => installed }
  package { 'python-nose':       ensure => installed }
  package { 'python3-nose':      ensure => installed }
  package { 'cookiecutter':      ensure => installed }
  package { 'python-virtualenv': ensure => installed }
  package { 'python-twisted':    ensure => installed }
  package { 'python-autopep8':   ensure => installed }
  package { 'python-rope':       ensure => installed }
  package { 'python-jedi':       ensure => installed }
  package { 'python3-jedi':      ensure => installed }

  include dev::cowbuilder

}
