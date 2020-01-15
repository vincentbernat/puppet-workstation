# system-related applications

class system {

  include system::sudo
  include system::network
  include system::disk
  include system::postfix
  include system::imap
  include system::ssh
  include system::logging
  include system::plymouth

  package { "ca-certificates": ensure => installed }
  package { "ca-cacert":       ensure => absent }
  package { "sysfsutils":      ensure => installed }
  package { "ncdu":            ensure => installed }
  package { "fwupd":           ensure => installed }
  package { "acpi":            ensure => installed }
  package { "at":              ensure => absent }
  package { "ntp":             ensure => absent }
  package { "sntp":            ensure => absent }
  package { "mlocate":         ensure => purged }
  package { "powertop":        ensure => installed }
  package { "linux-cpupower":  ensure => installed }
  package { "systemd-sysv":    ensure => installed } ->
  package { 'systemd-cron':    ensure => installed } ->
  package { ["initscripts", "sysv-rc", "insserv", "startpar",
             "rpcbind",
             "cron", "anacron"]:
    ensure => purged
  }

  # Defragmentation of transparent huge page can slow down a host when
  # copying to slow devices (like USB keys)
  file { "/etc/sysfs.d/usb-performance.conf":
    content => "kernel/mm/transparent_hugepage/defrag = madvise\n",
    notify => Service["sysfsutils"],
    require => Package["sysfsutils"]
  }

  udev::rule { '70-more-uaccess.rules':
    source => 'puppet:///modules/system/uaccess.rules'
  }
  file { '/etc/modprobe.d/iwlwifi-btcoex.conf':
    source => 'puppet:///modules/system/iwlwifi-btcoex.conf',
    notify => Exec['update initramfs for modprobe']
  }

  exec { 'update initramfs for modprobe':
    command     => '/usr/sbin/update-initramfs -k all -u',
    refreshonly => true
  }

  service { "sysfsutils": }
  service { "puppet":
    ensure => stopped,
    enable => false
  }

  class { "timezone":
    timezone => "Europe/Paris"
  }
  service { "systemd-timesyncd":
    ensure => running,
    enable => true
  }

  # Enable user namespaces. This is a security risk, but I end up
  # enabling it after each boot anyway.
  sysctl { 'kernel.unprivileged_userns_clone': value => '1' }
}
