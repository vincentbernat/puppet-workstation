class system::disk {

  # discards should be enabled when supported (on SSD)
  package { "lvm2": ensure => installed }
  ->
  file_line { 'lvm should enable discard':
    ensure => present,
    line   => 'issue_discards = 1',
    match  => 'issue_discards = .',
    path   => '/etc/lvm/lvm.conf',
    notify => Exec['update initramfs for lvm']
  }

  exec { 'update initramfs for lvm':
    command => '/usr/sbin/update-initramfs -k all -u',
    refreshonly => true
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
    system::disk::fstab_add_option { "${title}-noatime":
      entry => $title,
      value => "noatime"
    }
  }

  $noatime = split($::fstab_missing_noatime, ',')
  system::disk::fstab_add_noatime { $noatime: }

  # For SSD, better use fstrim weekly
  service { "fstrim.timer":
    ensure => running,
    enable => true,
  }
}
