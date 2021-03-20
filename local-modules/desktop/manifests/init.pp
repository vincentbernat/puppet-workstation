# desktop-related applications

class desktop {

  include desktop::x11

  # Base desktop
  include desktop::audio
  include desktop::awesome
  include desktop::fonts

  # Some applications
  include desktop::emacs
  include desktop::chromium
  include desktop::latex
  include desktop::camera

  # various stuff
  package { 'desktop-base':              ensure => installed }
  package { ['zathura',
             'zathura-djvu',
             'zathura-ps',
             'zathura-cb']:              ensure => installed }
  package { 'file-roller':               ensure => installed }
  package { 'geeqie':                    ensure => installed }
  package { 'gitg':                      ensure => installed }
  package { 'gimp':                      ensure => installed }
  package { 'inkscape':                  ensure => installed }
  package { 'krita':                     ensure => installed }
  package { 'pinentry-curses':           ensure => installed }
  package { 'pinentry-gtk2':             ensure => installed }
  package { 'pinentry-gtk3':             ensure => absent }
  package { 'pinentry-gnome3':           ensure => absent }
  package { 'ristretto':                 ensure => installed }
  package { 'ssh-askpass-gnome':         ensure => present }
  package { 'ssh-askpass-fullscreen':    ensure => absent }
  package { 'ssh-askpass':               ensure => absent } # Buggy as hell
  package { 'thunar':                    ensure => installed }
  package { 'thunar-volman':             ensure => purged }
  package { 'unison':                    ensure => installed }
  package { 'vim-tiny':                  ensure => installed }
  package { 'vlc':                       ensure => installed }
  package { 'cups':                      ensure => installed }
  package { 'cups-browsed':              ensure => purged }
  package { 'wireshark':                 ensure => installed }
  package { 'libreoffice':               ensure => installed }
  package { 'libreoffice-gtk3':          ensure => installed }
  package { 'libreoffice-sdbc-firebird': ensure => purged }
  package { 'libreoffice-java-common':   ensure => purged }
  package { ['gvfs-daemons',
             'gvfs-backends',
             'gnome-settings-daemon',
             'at-spi2-core',
             'geoclue-2.0']:
    ensure => purged
  }

  # OpenCL
  package{ 'clinfo': ensure => installed }
  package{
    $facts['vga']['vendor'] ? {
      'Intel Corporation' => 'intel-opencl-icd',
      'Advanced Micro Devices, Inc. [AMD/ATI]' => 'mesa-opencl-icd',
      default => 'pocl-opencl-icd'
    }: ensure => installed
  }

  package { 'mpv': ensure => installed }
  -> file { '/etc/mpv/mpv.conf':
    content => template('desktop/mpv.conf.erb')
  }

  # Firefox
  package { 'firefox':            ensure => installed } ->
  package { 'firefox-l10n-fr':    ensure => installed } ->
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
             'com.discordapp.Discord',
             'com.microsoft.Teams',
             'com.skype.Client',
             'com.slack.Slack',
             'com.snes9x.Snes9x',
             'com.spotify.Client',
             'com.valvesoftware.Steam',
             'org.signal.Signal',
             'us.zoom.Zoom',
             ]:
    ensure => installed,
    remote => 'flathub'
  }
  # For permissions, check with "flatpak info -M us.zoom.Zoom"
  -> file { ["/var/lib/flatpak/overrides/com.skype.Client", "/var/lib/flatpak/overrides/org.signal.Signal"]:
    content => @(END)
      [Context]
      filesystems=!home;
      | END
  }
  -> file { "/var/lib/flatpak/overrides/us.zoom.Zoom":
    content => @(END)
      [Context]
      filesystems=!home;~/.zoom;
      | END
  }
  -> file { "/var/lib/flatpak/overrides/com.spotify.Client":
    content => @(END)
      [Context]
      filesystems=!xdg-pictures;
      | END
  }
  -> file { "/var/lib/flatpak/overrides/global":
    content => @(END)
      [Environment]
      XCURSOR_THEME=Adwaita;
      | END
  }

  # Xsession shouldn't start much stuff
  file_line { 'no Xsession dbus':
    ensure => absent,
    line   => 'use-session-dbus',
    path   => '/etc/X11/Xsession.options'
  }
  file_line { 'no Xsession ssh-agent':
    ensure => absent,
    line   => 'use-ssh-agent',
    path   => '/etc/X11/Xsession.options'
  }
}
