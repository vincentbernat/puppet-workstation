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
  package { 'libreoffice-java-common':   ensure => purged }
  package { ['gvfs-daemons', 'gvfs-backends', 'gnome-settings-daemon', 'geoclue-2.0']:
    ensure => purged
  }

  package { 'mpv': ensure => installed }
  -> file { '/etc/mpv/mpv.conf':
    content => template('desktop/mpv.conf.erb')
  }

  # Firefox
  package { 'firefox':            ensure => installed } ->
  package { 'firefox-l10n-fr':    ensure => installed } ->
  package { 'webext-browserpass': ensure => installed }
  package { 'firefox-esr':        ensure => purged }
  package { 'iceweasel':          ensure => purged }
  package { 'gstreamer1.0-vaapi': ensure => installed }

  # Blacklisting some annoying packages
  package { 'gnome-keyring':       ensure => absent }
  package { 'flashplugin-nonfree': ensure => purged }

  # Software packaged with Flatpak
  flatpak_remote { 'flathub':
    ensure   => present,
    location => 'https://flathub.org/repo/flathub.flatpakrepo'
  }
  ->
  flatpak { [
             'com.obsproject.Studio',
             'com.skype.Client',
             'com.slack.Slack',
             'com.snes9x.Snes9x',
             'com.spotify.Client',
             'us.zoom.Zoom',
             ]:
    ensure => installed,
    remote => 'flathub'
  }
}
