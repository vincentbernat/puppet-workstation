class system::sudo {

  User <| title == "${::user}" |> {
    require => Package["sudo"],
    groups +> "sudo"
  }

  class { 'sudo':
    config_file_replace => false,
  }

  sudo::conf { 'apt':
    content => "%sudo ALL=(ALL) NOPASSWD: /usr/bin/apt update, /usr/bin/apt full-upgrade, /usr/bin/apt autoremove"
  }
  sudo::conf { 'brightness':
    content => "%sudo ALL=(ALL) NOPASSWD: /usr/bin/tee /sys/class/backlight/intel_backlight/brightness"
  }
  sudo::conf { 'systemctl':
    content => "%sudo ALL=(ALL) NOPASSWD: /usr/bin/systemctl start *, /usr/bin/systemctl restart *, /usr/bin/systemctl stop *, /usr/bin/systemctl status *"
  }
}
