# system-related applications

class system {

  include system::sudo
  include system::network
  include system::disk
  include system::postfix
  include system::imap
  include system::ssh
  include system::docker
  include system::logging
  include system::boot

  package { [
    "acpi",
    "busybox-static",
    "ca-certificates",
    "firmware-amd-graphics",
    "firmware-intel-sound",
    "firmware-iwlwifi",
    "firmware-linux-free",
    "firmware-linux-nonfree",
    "firmware-misc-nonfree",
    "firmware-realtek",
    "fwupd",
    "inxi",
    "linux-cpupower",
    "ncdu",
    "sysfsutils"
  ]:
    ensure => installed
  }
  package { "systemd-sysv":      ensure => installed } ->
  package { 'systemd-coredump':  ensure => installed } ->
  package { 'systemd-container': ensure => installed } ->
  package { 'systemd-cron':      ensure => installed } ->
  package { [
    "anacron",
    "at",
    "cron",
    "initscripts",
    "insserv",
    "mlocate",
    "ntp",
    "rpcbind",
    "sntp",
    "startpar",
    "sysv-rc"
  ]:
    ensure => purged
  }

  # udev module setup
  file { '/sbin/udevadm':
    ensure => link,
    target => '../bin/udevadm'
  } ->
  class { "udev": }

  # Laptop tools
  if $facts['laptop'] {
    package { "tlp":             ensure => installed }
    package { "powertop":        ensure => installed }
  }

  # Locales
  class { 'locales':
    default_locale => 'en_US.UTF-8',
    locales        => ['en_US.UTF-8 UTF-8', 'fr_FR.UTF-8 UTF-8']
  }

  # Do not start anything as a user by default
  file { ["/etc/systemd/user/default.target.wants",
          "/etc/systemd/user/graphical-session-pre.target.wants",
          "/etc/systemd/user/graphical-session.target.wants"]:
    ensure  => directory,
    purge   => true,
    recurse => true
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
    notify => Exec['update initramfs']
  }
  if $facts['dmi']['manufacturer'] == 'LENOVO' and $facts['dmi']['product']['name'] == '20A7005UMZ' {
    # Don't use SMB to access trackpoint on Lenovo (buggy)
    file { '/etc/modprobe.d/rmi-smbus-blacklist.conf':
      source => 'puppet:///modules/system/rmi-smbus-blacklist.conf',
      notify => Exec['update initramfs']
    }
    # Enable PSR (better battery life)
    file { '/etc/modprobe.d/i915-psr.conf':
      source => 'puppet:///modules/system/i915-psr.conf',
      notify => Exec['update initramfs']
    }
    # Prefer MBIM over ACM
    file { '/etc/modprobe.d/prefer-mbim.conf':
      source => 'puppet:///modules/system/prefer-mbim.conf',
      notify => Exec['update initramfs']
    }
  }
  file { '/etc/initramfs-tools/conf.d/modules':
    content => "MODULES=dep\n"
  }
  ~>
  exec { 'update initramfs':
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
}
