class fonts {

  # fonts
  package { "fonts-dejavu": ensure => installed }
  package { "fonts-dejavu-extra": ensure => installed }
  package { "fonts-droid": ensure => installed }
  package { "fonts-freefont-ttf": ensure => installed }
  package { "fonts-liberation": ensure => installed }
  package { "fonts-inconsolata": ensure => installed }
  package { "ttf-mscorefonts-installer": ensure => installed }
  package { "xfonts-terminus": ensure => installed }

  exec { "retrieve_powerline":
    command => "/usr/bin/wget -q https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf -O /usr/local/share/fonts/PowerlineSymbols.otf",
    creates => "/usr/local/share/fonts/PowerlineSymbols.otf",
    notify => Exec["build_fontconfig_cache"]
  }
  exec { "build_fontconfig_cache":
    refreshonly => true,
    command => "/usr/bin/fc-cache"
  }

  # fontconfig
  package { "fontconfig": ensure => installed }
  ->
  file { "/etc/fonts/conf.d/10-sub-pixel-rgb.conf":
    ensure => link,
    source => "/usr/share/fontconfig/conf.avail/10-sub-pixel-rgb.conf"
  }
  file { "/etc/fonts/conf.d/55-look-better.conf":
    source => "puppet:///modules/desktop/fonts/look-better.conf"
  }

}
