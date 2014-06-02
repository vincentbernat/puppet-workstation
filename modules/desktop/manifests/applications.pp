class applications {

  # various stuff
  package { "desktop-base": ensure => installed }
  package { "evince": ensure => installed }
  package { "geeqie": ensure => installed }
  package { "giggle": ensure => installed }
  package { "gimp": ensure => installed }
  package { "gpicview": ensure => installed }
  package { "iceweasel": ensure => installed }
  package { "inkscape": ensure => installed }
  package { "mdbus2": ensure => installed }
  package { "mplayer": ensure => installed }
  package { "pidgin": ensure => installed } ->
  package { "pidgin-skype": ensure => installed }
  package { "pinentry-gtk2": ensure => installed }
  package { "thunar": ensure => installed }
  package { "unison": ensure => installed }
  package { "vim-tiny": ensure => installed }
  package { "vlc": ensure => installed }
  package { "wireshark": ensure => installed }

  # fonts
  package { "fonts-dejavu": ensure => installed }
  package { "fonts-dejavu-extra": ensure => installed }
  package { "fonts-droid": ensure => installed }
  package { "fonts-freefont-ttf": ensure => installed }
  package { "fonts-liberation": ensure => installed }
  package { "fonts-inconsolata": ensure => installed }
  package { "ttf-mscorefonts-installer": ensure => installed }

}
