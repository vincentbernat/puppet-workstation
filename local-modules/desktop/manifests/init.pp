# desktop-related applications

class desktop {

  include desktop::x11

  # Base desktop
  include desktop::audio
  include desktop::i3
  include desktop::fonts

  # Some applications
  include desktop::emacs
  include desktop::latex
  include desktop::camera

  # various stuff
  package { 'desktop-base':              ensure => installed }
  package { ['zathura',
             'zathura-djvu',
             'zathura-ps',
             'zathura-cb']:              ensure => installed }
  package { 'file-roller':               ensure => installed }
  package { 'gitg':                      ensure => installed }
  package { 'gimp':                      ensure => absent }
  package { 'virt-manager':              ensure => installed }
  package { 'inkscape':                  ensure => installed }
  package { 'krita':                     ensure => installed }
  package { 'pinentry-curses':           ensure => installed }
  package { 'pinentry-gtk2':             ensure => installed }
  package { 'pinentry-gtk3':             ensure => absent }
  package { 'pinentry-gnome3':           ensure => absent }
  package { 'sxiv':                      ensure => installed }
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
  package { 'system-config-printer':     ensure => installed }
  package { ['foomatic-db',
             'openprinting-ppds']:       ensure => installed }
  package { 'wireshark':                 ensure => installed }
  package { ['gvfs-daemons',
             'gvfs-backends',
             'gnome-online-miners',
             'gnome-settings-daemon',
             'at-spi2-core',
             'geoclue-2.0']:
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
  package { 'gstreamer1.0-vaapi': ensure => installed }

  # Blacklisting some annoying packages
  package { 'gnome-keyring':       ensure => absent }

  # Software packaged with Flatpak
  flatpak_remote { 'flathub':
    ensure   => present,
    location => 'https://flathub.org/repo/flathub.flatpakrepo'
  }
  flatpak_remote { 'flathub-beta':
    ensure   => present,
    location => 'https://flathub.org/beta-repo/flathub-beta.flatpakrepo'
  }
  file { "/var/lib/flatpak/overrides":
    ensure => directory
  } -> file { "/var/lib/flatpak/overrides/global":
    content => @(END)
      [Environment]
      XCURSOR_THEME=Adwaita;
      | END
  }
  define flatpak($permissions = undef, $remote = 'flathub') {
    flatpak { $title:
      ensure  => installed,
      remote  => $remote,
      require => Flatpak_Remote[$remote]
    }
    # For permissions, check with "flatpak info -M us.zoom.Zoom"
    ->
    file { "/var/lib/flatpak/overrides/${title}":
      ensure  => $permissions ? { undef => absent, default => present },
      content => @("END")
        [Context]
        ${permissions}
        | END
    }
  }

  desktop::flatpak { "com.jgraph.drawio.desktop":
    permissions => "filesystems=!home;xdg-documents;xdg-download;~/code"
  }
  desktop::flatpak {"org.signal.Signal":
    permissions => "filesystems=!home;!xdg-pictures;!xdg-music;!xdg-videos;!xdg-documents"
  }
  desktop::flatpak {"org.onlyoffice.desktopeditors":
    permissions => @("END")
      filesystems=!host;!/tmp
      devices=!all;dri
      | END
  }
  desktop::flatpak { "org.gimp.GIMP":
    remote => "flathub-beta"
  }
  desktop::flatpak { "org.gtk.Gtk3theme.Adwaita-dark": }
  desktop::flatpak { "us.zoom.Zoom": }
  desktop::flatpak { "com.spotify.Client":
    permissions => "filesystems=!xdg-pictures"
  }
  desktop::flatpak { "com.discordapp.Discord":
    permissions => "filesystems=!xdg-pictures;!xdg-videos"
  }
  desktop::flatpak { "com.valvesoftware.Steam":
    permissions => "filesystems=!xdg-pictures;!xdg-music"
  }
  desktop::flatpak { "com.github.Eloston.UngoogledChromium":
    permissions => "filesystems=!home;xdg-download"
  }
  desktop::flatpak { "org.jitsi.jitsi-meet":
    permissions => "filesystems=!home"
  }
  desktop::flatpak { "org.libretro.RetroArch":
    permissions => "filesystems=!home;!host;~/games/ROMs"
  }
  desktop::flatpak { "com.anydesk.Anydesk":
    permissions => "filesystems=!home"
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
