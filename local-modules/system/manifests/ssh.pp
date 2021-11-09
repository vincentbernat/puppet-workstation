class system::ssh {

  package { "openssh-server": ensure => installed }
  ->
  sshd_config { ["PermitRootLogin",
                 "PasswordAuthentication",
                 "KbdInteractiveAuthentication"]:
    ensure => present,
    value  => "no",
  }
  ~>
  service { "ssh":
    ensure => running,
  }

}
