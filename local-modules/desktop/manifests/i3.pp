class desktop::i3 {
  package { ['adwaita-icon-theme',
             'adwaita-qt',
             'adwaita-qt6',
             'alsa-utils',
             'attr',
             'autorandr',
             'bc',
             'dconf-cli',
             'gnome-icon-theme',
             'gnome-themes-extra',
             'gnupg-agent',
             'hsetroot',
             'inputplug',
             'libgtk3-nocsd0',
             'libnotify-bin',
             'libvte-2.91-0',
             'maim',
             'picom',
             'playerctl',
             'policykit-1-gnome',
             'python3-dbussy',
             'python3-gi-cairo',
             'python3-gst-1.0',
             'python3-i3ipc',
             'python3-pil',
             'python3-systemd',
             'python3-xattr',
             'python3-xcffib',
             'python3-xlib',
             'qt5ct',
             'redshift',
             'rofi',
             'x11-xkb-utils',
             'x11-xserver-utils',
             'xclip',
             'xdg-utils',
             'xdotool',
             'xiccd',
             'xinput',
             'xprintidle',
             'xsecurelock',
             'xsel',
             'xsettingsd',
             'xss-lock']:
               ensure => installed
  }
  ->
  file_line { 'lower CPU usage of python3-dbussy':
    ensure => present,
    line   => '            self.loop.call_later(1, self._reaper, weak_ref(self))',
    match  => '            self.loop.call_.*self._reaper',
    path   => '/usr/lib/python3/dist-packages/dbussy.py',
    multiple => true,
    append_on_no_match => false,
    replace_all_matches_not_matching_line => true,
  }

  package { 'brightnessctl':
    ensure          => installed,
    install_options => ['--no-install-recommends']
  }
  package { 'brightness-udev':
    ensure => purged
  }

  # Prevent autorandr to run on monitor plug or on sleep.
  service { ['autorandr', 'autorandr-lid-listener']:
    enable => mask,
    ensure => stopped
  }
  file { '/etc/pm/sleep.d/40autorandr':
    ensure => absent
  }

}
