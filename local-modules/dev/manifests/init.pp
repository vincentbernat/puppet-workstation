class dev {

  # Debian
  package { 'build-essential':  ensure => installed }
  package { 'dpkg-dev':         ensure => installed }
  package { 'debhelper':        ensure => installed }
  package { 'git-buildpackage': ensure => installed }
  package { 'dput-ng':          ensure => installed }
  package { 'ubuntu-dev-tools': ensure => installed }
  package { 'lintian':          ensure => installed }
  package { 'lintian-brush':    ensure => installed }
  include dev::cowbuilder

  package { 'nodejs': ensure => installed }

  # C-related
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

  # Python-related
  package { 'ipython3':          ensure => installed }
  package { 'python3-all-dev':   ensure => installed }
  package { 'tox':               ensure => installed }
  package { 'python3-pytest':    ensure => installed }
  package { 'cookiecutter':      ensure => installed }
  package { 'python-virtualenv': ensure => installed }
  package { 'python3-jedi':      ensure => installed }
}
