class system::sudo {

  User <| title == "${::user}" |> {
    require => Package["sudo"],
    groups +> "sudo"
  }

  class { 'sudo':
    config_file_replace => false,
  }

  file { '/etc/environment':
    content => @(ENV/L)
      # Managed by Puppet
      LESSSECURE=1
      | ENV
  }
  file_line { 'make sudo read /etc/environment':
    require => Package[sudo],
    line    => 'session required pam_env.so',
    path    => '/etc/pam.d/sudo',
    after   => "#%PAM-1.0"
  }

  sudo::conf { 'apt':
    content => @(SUDO/L)
      %sudo ALL=(ALL) NOPASSWD:\
       /usr/bin/apt update,\
       /usr/bin/apt autoremove,\
       /usr/bin/apt autoclean,\
       /usr/bin/aptitude purge ~o,\
       /usr/bin/aptitude purge ~c,\
       /usr/bin/flatpak update
      |- SUDO
  }
  sudo::conf { 'systemctl':
    content => @(SUDO/L)
      %sudo ALL=(ALL) NOPASSWD:\
       /usr/bin/systemctl suspend,\
       /usr/bin/systemctl start *,\
       /usr/bin/systemctl restart *,\
       /usr/bin/systemctl reload *,\
       /usr/bin/systemctl stop *,\
       /usr/bin/systemctl status,\
       /usr/bin/systemctl status *
      |- SUDO
  }
}
