# system-related applications

class system {

  include sudo
  include network
  include disk
  include postfix
  include imap

  package { "ca-certificates": ensure => installed }
  package { "systemd-sysv": ensure => installed }
  package { "openssh-server": ensure => installed }
  package { "sysfsutils": ensure => installed }
  package { "at": ensure => absent }

  # Defragmentation of transparent huge page can slow down a host when
  # copying to slow devices (like USB keys)
  file { "/etc/sysfs.d/usb-performance.conf":
    content => "kernel/mm/transparent_hugepage/defrag = madvise\n",
    notify => Service["sysfsutils"],
    require => Package["sysfsutils"]
  }

  service { "sysfsutils": }
  service { "puppet":
    ensure => stopped,
    enable => false
  }

  class { "timezone":
    timezone => "Europe/Zurich"
  }
}
