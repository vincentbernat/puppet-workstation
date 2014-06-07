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

  # Enable noatime and discard when needed
  define fstab_add_option($entry = $title, $value) {
    augeas { "insert ${value} for ${entry}":
      context => $entry,
      changes => [
                  "ins opt after opt[last()]",
                  "set opt[last()] '${value}'",
                  ];
    }
  }
  define fstab_add_noatime() {
    fstab_add_option { "${title}-noatime":
      value => "noatime"
    }
  }
  define fstab_add_nodiscard() {
    fstab_add_option { "${title}-nodiscard":
      value => "nodiscard"
    }
  }

  $noatime = split($::fstab_missing_noatime, ',')
  fstab_add_noatime { $noatime: }
  $nodiscard = split($::fstab_missing_discard, ',')
  fstab_add_nodiscard { $nodiscard: }

}
