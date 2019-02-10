class desktop::fonts {

  # fonts
  package { 'fonts-dejavu':              ensure => installed }
  package { 'fonts-dejavu-extra':        ensure => installed }
  package { 'fonts-droid-fallback':      ensure => installed }
  package { 'fonts-freefont-ttf':        ensure => installed }
  package { 'fonts-liberation':          ensure => installed }
  package { 'fonts-inconsolata':         ensure => purged }
  package { 'fonts-hack':                ensure => installed }
  package { 'fonts-roboto':              ensure => installed }
  package { 'fonts-symbola':             ensure => installed }
  package { 'fonts-noto-color-emoji':    ensure => installed }
  package { 'ttf-mscorefonts-installer': ensure => installed }
  package { 'xfonts-terminus':           ensure => installed }
  package { 'fonts-powerline':           ensure => purged }

  # fontconfig
  package { 'fontconfig': ensure => installed }
  ->
  file { '/etc/fonts/conf.d/10-sub-pixel-rgb.conf':
    ensure => absent
  }

}
