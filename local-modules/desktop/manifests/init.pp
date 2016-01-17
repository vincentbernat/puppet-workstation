# desktop-related applications

class desktop {

  include x11

  # Base desktop
  include pulseaudio
  include awesome
  include fonts

  # Some applications
  include emacs
  include chromium
  include spotify
  include skype
  include latex
  include camera

  # various stuff
  package { "desktop-base": ensure => installed }
  package { "evince-gtk": ensure => installed }
  package { "file-roller": ensure => installed }
  package { "geeqie": ensure => installed }
  package { "giggle": ensure => installed }
  package { "gimp": ensure => installed }
  package { "gpicview": ensure => installed }
  package { "inkscape": ensure => installed }
  package { "mdbus2": ensure => installed }
  package { "mpv": ensure => installed }
  package { "pidgin": ensure => installed } ->
  package { "pidgin-skype": ensure => installed } ->
  package { "pidgin-sipe": ensure => installed }
  package { "pinentry-curses": ensure => installed }
  package { "pinentry-gtk2": ensure => installed }
  package { "pinentry-gtk3": ensure => absent }
  package { "pinentry-gnome3": ensure => absent }
  package { "ssh-askpass-fullscreen": ensure => present }
  package { "ssh-askpass": ensure => absent } # Buggy as hell
  package { "thunar": ensure => installed }
  package { "unison": ensure => installed }
  package { "vim-tiny": ensure => installed }
  package { "vlc": ensure => installed }
  package { "wireshark": ensure => installed }
  package { "libreoffice": ensure => installed }
  package { "libreoffice-gtk": ensure => installed }

  # Iceweasel
  package { "iceweasel":
    ensure          => installed,
    install_options => '-t experimental'
  }

  # Blacklisting some annoying packages
  package { "gnome-keyring": ensure => absent }
  package { "gvfs-daemons": ensure => absent }
  package { "gvfs-bin": ensure => absent }
  package { "flashplugin-nonfree": ensure => purged }

}
