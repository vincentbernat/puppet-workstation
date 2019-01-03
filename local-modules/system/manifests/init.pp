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
  package { "at":              ensure => absent }
  package { "ntp":             ensure => absent }
  package { "sntp":            ensure => absent }
  package { "mlocate":         ensure => purged }
  package { "systemd-sysv":    ensure => installed } ->
  package { ["initscripts", "sysv-rc", "insserv", "startpar", "rpcbind"]:
    ensure => purged
  }

  # Defragmentation of transparent huge page can slow down a host when
  # copying to slow devices (like USB keys)
  file { "/etc/sysfs.d/usb-performance.conf":
    content => "kernel/mm/transparent_hugepage/defrag = madvise\n",
    notify => Service["sysfsutils"],
    require => Package["sysfsutils"]
  }

  # Enable power control for most devices
  udev::rule { "20-autosuspend.rules":
    ensure => absent
  }
  udev::rule { "90-autosuspend.rules":
    source => 'puppet:///modules/system/autosuspend.rules'
  }
  udev::rule { '70-more-uaccess.rules':
    source => 'puppet:///modules/system/uaccess.rules'
  }
  # Fix trackpoint speed
  udev::rule { '90-trackpoint.rules':
    source => 'puppet:///modules/system/trackpoint.rules'
  }

  service { "sysfsutils": }
  service { "puppet":
    ensure => stopped,
    enable => false
  }

  class { "timezone":
    timezone => "Europe/Zurich"
  }
  service { "systemd-timesyncd":
    ensure => running,
    enable => true
  }

  # We need vsyscall emulation to be able to use older distributions
  # (like wheezy). This is set to none with recent Debian kernels.
  kernel_parameter { "vsyscall":
    ensure => present,
    value  => "emulate"
  }

  package { 'tlp': ensure => installed } ->
  file_line { 'disable usb autosuspend':
    ensure => present,
    line   => 'USB_AUTOSUSPEND=0',
    match  => '^USB_AUTOSUSPEND=.',
    path   => '/etc/default/tlp'
  } ->
  file_line { 'enable/disable WOL':
    ensure    => present,
    line      => $facts['laptop'] ? {
      true    => 'WOL_DISABLE=Y',
      default => 'WOL_DISABLE=N',
    },
    match     => '^WOL_DISABLE=.',
    path      => '/etc/default/tlp'
  }

}
