# system-related applications

class system {

  include sudo

  package { "resolvconf": ensure => installed }
  package { "ca-certificates": ensure => installed }
  package { "systemd-sysv": ensure => installed }
}
