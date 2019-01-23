# desktop-related applications

class desktop {

  include desktop::x11

  # Base desktop
  include desktop::pulseaudio
  include desktop::awesome
  include desktop::fonts

  # Some applications
  include desktop::emacs
  include desktop::chromium
  include desktop::spotify
  include desktop::latex
  include desktop::camera

  # various stuff
  package { 'desktop-base':              ensure => installed }
  package { 'evince':                    ensure => installed }
  package { 'file-roller':               ensure => installed }
  package { 'geeqie':                    ensure => installed }
  package { 'giggle':                    ensure => installed }
  package { 'gimp':                      ensure => installed }
  package { 'gpicview':                  ensure => installed }
  package { 'inkscape':                  ensure => installed }
  package { 'mpv':                       ensure => installed }
  package { 'pinentry-curses':           ensure => installed }
  package { 'pinentry-gtk2':             ensure => installed }
  package { 'pinentry-gtk3':             ensure => absent }
  package { 'pinentry-gnome3':           ensure => absent }
  package { 'ssh-askpass-gnome':         ensure => present }
  package { 'ssh-askpass-fullscreen':    ensure => absent }
  package { 'ssh-askpass':               ensure => absent } # Buggy as hell
  package { 'thunar':                    ensure => installed }
  package { 'unison':                    ensure => installed }
  package { 'vim-tiny':                  ensure => installed }
  package { 'vlc':                       ensure => installed }
  package { 'wireshark':                 ensure => installed }
  package { 'libreoffice':               ensure => installed }
  package { 'libreoffice-gtk3':          ensure => installed }
  package { 'libreoffice-sdbc-firebird': ensure => purged }
  package { ['gnome-settings-daemon', 'gvfs-daemons', 'gvfs-backends']:
    ensure          => installed,
    install_options => ['--no-install-recommends']
  }

  # Firefox
  package { 'firefox':            ensure => installed }
  package { 'firefox-esr':        ensure => purged }
  package { 'iceweasel':          ensure => purged }
  package { 'gstreamer1.0-vaapi': ensure => installed }

  # Blacklisting some annoying packages
  package { 'gnome-keyring':       ensure => absent }
  package { 'flashplugin-nonfree': ensure => purged }

}
