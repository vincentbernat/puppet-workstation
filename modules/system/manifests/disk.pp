class disk {

  udev::rule { "60-schedulers.rules":
    source => 'puppet:///modules/system/disk/schedulers.rules',
  }

}
