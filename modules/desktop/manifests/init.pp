# desktop-related applications

class desktop {

  include x11

  # Base desktop
  include pulseaudio
  include awesome
  include urxvt
  include fonts

  # Some applications
  include emacs
  include chromium
  include spotify
  include skype

  # various stuff
  package { "desktop-base": ensure => installed }
  package { "evince": ensure => installed }
  package { "geeqie": ensure => installed }
  package { "giggle": ensure => installed }
  package { "gimp": ensure => installed }
  package { "gpicview": ensure => installed }
  package { "iceweasel": ensure => installed }
  package { "inkscape": ensure => installed }
  package { "keepassx": ensure => installed }
  package { "mdbus2": ensure => installed }
  package { "mpv": ensure => installed }
  package { "pidgin": ensure => installed } ->
  package { "pidgin-skype": ensure => installed } ->
  package { "pidgin-sipe": ensure => installed }
  package { "pinentry-gtk2": ensure => installed }
  package { "thunar": ensure => installed }
  package { "unison": ensure => installed }
  package { "vim-tiny": ensure => installed }
  package { "vlc": ensure => installed }
  package { "wireshark": ensure => installed }

  package { "gnome-keyring": ensure => absent }
  package { "gvfs-daemons": ensure => absent }

}
