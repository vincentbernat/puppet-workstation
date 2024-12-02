class dev {

  # Debian
  package { 'build-essential':  ensure => installed }
  package { 'dpkg-dev':         ensure => installed }
  package { 'debhelper':        ensure => installed }
  package { 'git-buildpackage': ensure => installed }
  package { 'dput-ng':          ensure => installed }
  package { 'lintian':          ensure => installed }
  package { 'lintian-brush':    ensure => installed }
  package { 'sbuild':           ensure => installed }
  include dev::cowbuilder

  # C-related
  package { 'make':            ensure => installed }
  package { 'pkgconf':         ensure => installed }
  package { 'autoconf':        ensure => installed }
  package { 'automake':        ensure => installed }
  package { 'libtool':         ensure => installed }
  package { 'gdb':             ensure => installed }
  package { 'valgrind':        ensure => installed }
  package { 'ccache':          ensure => installed }
  package { 'bear':            ensure => installed }
  package { 'clang':           ensure => installed }
  package { 'clang-format':    ensure => installed }
  package { 'ccls':            ensure => installed }

  # Python-related
  package { 'ipython3':           ensure => installed }
  package { 'python3-all-dev':    ensure => installed }
  package { 'python-is-python3':  ensure => installed }
  package { 'tox':                ensure => installed }
  package { 'pipenv':             ensure => installed }
  package { 'python3-pytest':     ensure => installed }
  package { 'python3-virtualenv': ensure => installed }
  package { 'python3-pip':        ensure => installed }
  package { 'python3-jedi':       ensure => installed }
  package { 'python3-poetry':     ensure => installed }
  package { 'black':              ensure => installed }
  package { 'isort':              ensure => installed }
  package { 'pyflakes3':          ensure => installed }
  package { 'mypy':               ensure => installed }

  # Go-related
  package { 'golang':                ensure => installed }
  package { 'gopls':                 ensure => installed }
  package { 'golang-golang-x-tools': ensure => installed }
  package { 'delve':                 ensure => installed }

  # Others
  package { ['nodejs',
             'uglifyjs']:  ensure => installed }
}
