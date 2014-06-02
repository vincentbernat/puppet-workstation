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
}
