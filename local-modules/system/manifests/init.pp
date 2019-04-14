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
  udev::rule { "90-autosuspend.rules":
    ensure => absent
  }
  udev::rule { '70-more-uaccess.rules':
    source => 'puppet:///modules/system/uaccess.rules'
  }
  # Fix trackpoint speed
  udev::rule { '90-trackpoint.rules':
    source => 'puppet:///modules/system/trackpoint.rules'
  }

  if $facts['dmi']['manufacturer'] == 'LENOVO' {
    # Don't use SMB to access trackpoint on Lenovo (buggy)
    file { '/etc/modprobe.d/rmi-smbus-blacklist.conf':
      source => 'puppet:///modules/system/rmi-smbus-blacklist.conf',
      notify => Exec['update initramfs for modprobe']
    }
    # Enable PSR (better battery life)
    file { '/etc/modprobe.d/i915-psr.conf':
      source => 'puppet:///modules/system/i915-psr.conf',
      notify => Exec['update initramfs for modprobe']
    }
    # Prefer MBIM over ACM
    file { '/etc/modprobe.d/prefer-mbim.conf':
      source => 'puppet:///modules/system/prefer-mbim.conf',
      notify => Exec['update initramfs for modprobe']
    }
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
    timezone => "Europe/Zurich"
  }
  service { "systemd-timesyncd":
    ensure => running,
    enable => true
  }

  # Enable user namespaces. This is a security risk, but I end up
  # enabling it after each boot anyway.
  sysctl { 'kernel.unprivileged_userns_clone': value => '1' }
}
