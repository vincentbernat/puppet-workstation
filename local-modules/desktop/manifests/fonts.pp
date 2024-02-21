class desktop::fonts {

  # fonts
  package { 'fonts-cantarell':           ensure => installed }
  package { 'fonts-dejavu':              ensure => installed }
  package { 'fonts-dejavu-extra':        ensure => installed }
  package { 'fonts-droid-fallback':      ensure => installed }
  package { 'fonts-freefont-ttf':        ensure => installed }
  package { 'fonts-liberation':          ensure => installed }
  package { 'fonts-inconsolata':         ensure => purged }
  package { 'fonts-hack':                ensure => installed }
  package { 'fonts-roboto':              ensure => installed }
  package { 'fonts-symbola':             ensure => installed }
  package { 'fonts-noto':                ensure => installed }
  package { 'fonts-noto-color-emoji':    ensure => installed }
  package { 'fonts-terminus-otb':        ensure => installed }
  package { 'ttf-mscorefonts-installer': ensure => purged }
  package { 'ttf-bitstream-vera':        ensure => purged }
  package { 'fonts-powerline':           ensure => purged }

  # fontconfig
  package { 'fontconfig': ensure => installed } ->
  file { "/etc/fonts/conf.d/70-no-bitmaps.conf": ensure => absent }
}
