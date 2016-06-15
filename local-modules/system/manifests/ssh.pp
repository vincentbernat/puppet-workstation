class system::ssh {

  package { "openssh-server": ensure => installed }

  sshd_config { "PermitRootLogin":
    ensure => present,
    value => "no",
    require => Package["openssh-server"]
  }

  sshd_config { "PasswordAuthentication":
    ensure => present,
    value => "no",
    require => Package["openssh-server"]
  }

  Sshd_config {
    notify => Service[ssh]
  }

  service { "ssh":
    ensure => running,
    require => Package["openssh-server"]
  }

}
