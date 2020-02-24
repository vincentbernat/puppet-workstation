class system::ssh {

  package { "openssh-server": ensure => installed }

  sshd_config { "PermitRootLogin":
    ensure => present,
    value => "no",
    require => Package["openssh-server"],
    notify => Service[ssh]
  }

  sshd_config { "PasswordAuthentication":
    ensure => present,
    value => "no",
    require => Package["openssh-server"],
    notify => Service[ssh]
  }

  service { "ssh":
    ensure => running,
    require => Package["openssh-server"]
  }

}
