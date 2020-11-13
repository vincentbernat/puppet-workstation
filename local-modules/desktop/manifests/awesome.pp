class desktop::awesome {
  # awesome-extra=2012061101
  # awesome=3.4.15-1
  package { ['awesome',
             'awesome-extra']:
               mark => hold
  }
  ->
  file_line { 'accept actions for naughty notifications':
    # But ignore them...
    ensure => present,
    line => '        return "as", { "s", "body", "s", "body-markup", "s", "icon-static", "s", "actions" }',
    match => '        return "as", { "s", "body", "s", "body-markup", "s", "icon-static".*}',
    path => '/usr/share/awesome/lib/naughty.lua',
  }
  file_line { 'add is_suspended function':
    ensure => present,
    line => 'function is_suspended() return suspended end',
    path => '/usr/share/awesome/lib/naughty.lua',
  }

  package { ['adwaita-icon-theme',
             'adwaita-qt',
             'alsa-utils',
             'autorandr',
             'bc',
             'compton',
             'dconf-cli',
             'flameshot',
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
             'playerctl',
             'policykit-1-gnome',
             'python3-pil',
             'python3-xlib',
             'qt5ct',
             'redshift',
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
