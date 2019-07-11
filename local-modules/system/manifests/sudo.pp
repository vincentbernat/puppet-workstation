class system::sudo {

  User <| title == "${::user}" |> {
    require => Package["sudo"],
    groups +> "sudo"
  }

  class { 'sudo':
    config_file_replace => false,
  }

  sudo::conf { 'apt':
    content => @(SUDO/L)
      %sudo ALL=(ALL) NOPASSWD:\
       /usr/bin/apt update,\
       /usr/bin/apt full-upgrade,\
       /usr/bin/apt upgrade,\
       /usr/bin/apt autoremove,\
       /usr/bin/apt autoclean,\
       /usr/bin/aptitude safe-upgrade,\
       /usr/bin/flatpak update
      |- SUDO
  }
  sudo::conf { 'systemctl':
    content => @(SUDO/L)
      %sudo ALL=(ALL) NOPASSWD:\
       /usr/bin/systemctl start *,\
       /usr/bin/systemctl restart *,\
       /usr/bin/systemctl stop *,\
       /usr/bin/systemctl status *
      |- SUDO
  }
}
