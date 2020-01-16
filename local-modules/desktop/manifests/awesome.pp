class desktop::awesome {
  # awesome-extra=2012061101
  # awesome=3.4.15-1
  package { ['awesome',
             'awesome-extra']:
               ensure => held
  }

  package { ['adwaita-icon-theme',
             'alsa-utils',
             'autorandr',
             'bc',
             'compton',
             'dconf-cli',
             'fvwm',
             'fvwm-crystal',
             'gconf2',
             'gnome-icon-theme',
             'gnome-themes-standard',
             'gnupg-agent',
             'hsetroot',
             'i3lock',
             'inputplug',
             'libnotify-bin',
             'libvte-2.91-0',
             'numlockx',
             'playerctl',
             'policykit-1-gnome',
             'python3-pil',
             'python3-xlib',
             'redshift',
             'x11-xkb-utils',
             'x11-xserver-utils',
             'xdg-utils',
             'xdotool',
             'xfce4-terminal',
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

  # Prevent autorandr to run on monitor plug.
  service { 'autorandr':
    enable => mask
  }

}
