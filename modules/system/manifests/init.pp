# system-related applications

class system {

  include sudo
  include network
  include disk

  package { "ca-certificates": ensure => installed }
  package { "systemd-sysv": ensure => installed }
  package { "openssh-server": ensure => installed }

  # Defragmentation of transparent huge page can slow down a host when
  # copying to slow devices (like USB keys)
  file { "/etc/sysfs.d/usb-performance.conf":
    content => "kernel/mm/transparent_hugepage/defrag = madvise",
    notify => Service["sysfsutils"]
  }

  service { "sysfsutils": }
}
