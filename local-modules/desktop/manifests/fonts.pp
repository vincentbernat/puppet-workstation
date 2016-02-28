class fonts {

  # fonts
  package { "fonts-dejavu": ensure => installed }
  package { "fonts-dejavu-extra": ensure => installed }
  package { "fonts-droid-fallback": ensure => installed }
  package { "fonts-freefont-ttf": ensure => installed }
  package { "fonts-liberation": ensure => installed }
  package { "fonts-inconsolata": ensure => installed }
  package { "ttf-mscorefonts-installer": ensure => installed }
  package { "ttf-ancient-fonts": ensure => installed }
  package { "xfonts-terminus": ensure => installed }
  package { "fonts-powerline": ensure => installed }

  file { "/usr/local/share/fonts/PowerlineSymbols.otf":
    ensure => absent
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
