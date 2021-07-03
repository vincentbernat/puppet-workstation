class desktop::i3 {
  package { ['adwaita-icon-theme',
             'adwaita-qt',
             'alsa-utils',
             'autorandr',
             'bc',
             'dconf-cli',
             'flameshot',
             'gconf2',
             'gnome-icon-theme',
             'gnome-themes-standard',
             'gnupg-agent',
             'hsetroot',
             'i3',
             'i3lock',
             'inputplug',
             'libnotify-bin',
             'libvte-2.91-0',
             'picom',
             'playerctl',
             'policykit-1-gnome',
             'polybar',
             'python3-pil',
             'python3-xlib',
             'qt5ct',
             'redshift',
             'slop',
             'x11-xkb-utils',
             'x11-xserver-utils',
             'xclip',
             'xdg-utils',
             'xdotool',
             'xiccd',
             'xinput',
             'xsel',
             'xsettingsd',
             'xss-lock']:
               ensure => installed
  }

  package { 'brightnessctl':
    ensure          => installed,
    install_options => ['--no-install-recommends']
  }

  # Prevent autorandr to run on monitor plug or on sleep.
  service { 'autorandr':
    enable => mask
  }
  file { '/etc/pm/sleep.d/40autorandr':
    ensure => absent
  }

}
