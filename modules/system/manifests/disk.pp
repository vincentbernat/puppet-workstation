class disk {

  udev::rule { "60-schedulers.rules":
    source => 'puppet:///modules/system/disk/schedulers.rules',
  }

  # discards should be enabled when supported (on SSD)
  package { "lvm2": ensure => installed }
  ->
  file_line { 'lvm should enable discard':
    ensure => present,
    line   => 'issue_discards = 1',
    match  => 'issue_discards = .',
    path   => '/etc/lvm/lvm.conf',
  }

  # Enable noatime to all ext partitions
  define fstab_add_option($entry = $title, $value) {
    augeas { "insert noatime for ${entry}":
      context => $entry,
      changes => [
                  "ins opt after opt[last()]",
                  "set opt[last()] 'noatime'",
                  ];
    }
  }

  $noatime = split($::fstab_missing_noatime, ',')
  fstab_add_option {
    $noatime:
      value => 'noatime';
  }

  # Enabling discard would be handy, but dunno how to detect SSD when
  # they are baked by LVM...

}
