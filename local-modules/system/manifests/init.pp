# system-related applications

class system {

  include system::sudo
  include system::network
  include system::disk
  include system::postfix
  include system::ssh
  include system::docker
  include system::logging
  include system::boot

  package { [
    "acpi",
    "busybox-static",
    "ca-certificates",
    "firmware-realtek",
    "fwupd",
    "inxi",
    "linux-cpupower",
    "ncdu",
    "sysfsutils",
    "usbguard"
  ]:
    ensure => installed
  }
  package { "systemd-sysv":       ensure => installed } ->
  package { 'systemd-coredump':   ensure => installed } ->
  package { 'systemd-container':  ensure => installed } ->
  package { 'systemd-cryptsetup': ensure => installed } ->
  package { 'systemd-cron':       ensure => installed } ->
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
  if $facts['drm']['card0']['driver'] == 'amdgpu' {
    package { "firmware-amd-graphics": ensure => installed }
  }
  if $facts['drm']['card0']['driver'] == 'i915' {
    package { "firmware-misc-nonfree": ensure => installed }
  }

  # Laptop tools
  if $facts['laptop'] {
    package { "tlp":      ensure => installed }
    ->
    file { '/etc/tlp.d/01-custom.conf':
      ensure => present,
      source => "puppet:///modules/system/tlp.conf"
    }
    ~>
    service { "tlp":
      ensure => running,
      enable => true
    }
    sudo::conf { 'tlp':
      content => @(SUDO/L)
        %sudo ALL=(ALL) NOPASSWD:\
         /usr/bin/tlp fullcharge,\
         /usr/bin/tlp-stat -b
        |- SUDO
    }
    package { "powertop": ensure => installed }
    ->
    service { "powertop": enable => false }
  } else {
    package { "tlp":      ensure => purged }
  }

  # Locales
  class { 'locales':
    default_locale => 'en_US.UTF-8',
    locales        => ['en_US.UTF-8 UTF-8', 'fr_FR.UTF-8 UTF-8'],
    default_file   => "/etc/locale.conf"
  }

  # Do not start anything as a user by default
  file { ["/etc/systemd/user/default.target.wants",
          "/etc/systemd/user/graphical-session-pre.target.wants",
          "/etc/systemd/user/graphical-session.target.wants"]:
    ensure  => directory,
    purge   => true,
    recurse => true
  }

  file { "/etc/sysfs.d/usb-performance.conf":
    ensure => absent
  }

  # Prepare for KSM, but disable it
  file { "/etc/sysfs.d/ksm.conf":
    notify => Service["sysfsutils"],
    require => Package["sysfsutils"],
    content => @(END)
      kernel/mm/ksm/pages_to_scan=1000
      | END
  }

  package { "ksmtuned":
    ensure => present
  }
  ->
  service { ["ksm", "ksmtuned"]:
    ensure => stopped,
    enable => false
  }
  # When needed: systemctl start ksm

  # Cleanup /var/tmp
  systemd::tmpfile { 'vartmp.conf':
    content => @(END)
      # Managed by Puppet
      q /var/tmp 1777 root root 30d
      |END
  }

  file { '/etc/udev/rules.d/70-more-uaccess.rules':
    source => 'puppet:///modules/system/uaccess.rules'
  }
  ~>
  exec { 'update udev':
    refreshonly => true,
    command     => "/usr/bin/udevadm trigger --action=change"
  }
  if $facts['dmi']['manufacturer'] == 'LENOVO' and $facts['dmi']['product']['name'] == '20A7005UMZ' {
    package { "firmware-iwlwifi": ensure => installed }
    # Disable wifi/BT coexistence
    file { '/etc/modprobe.d/iwlwifi-btcoex.conf':
      source => 'puppet:///modules/system/iwlwifi-btcoex.conf',
      notify => Exec['update initramfs']
    }
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
  if $facts['dmi']['manufacturer'] == 'LENOVO' and $facts['dmi']['product']['name'] == '21D2CTO1WW' {
    # Workaround for non-working trackpoint in 6.10+
    file { '/etc/modprobe.d/trackpoint.conf':
      source => 'puppet:///modules/system/trackpoint.conf',
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

  file { "/etc/localtime":
    ensure => link,
    target => "/usr/share/zoneinfo/Europe/Paris"
  }
  service { "systemd-timesyncd":
    ensure => running,
    enable => true
  }

  # NSCD for Nix
  package { "nscd": ensure => installed }
  ->
  file { "/etc/nscd.conf":
    source => 'puppet:///modules/system/nscd.conf'
  }
  ~>
  service { "nscd":
    ensure => running,
    enable => true
  }
}
