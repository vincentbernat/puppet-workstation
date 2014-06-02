class disk {

  file {'/etc/udev/rules.d/60-schedulers.rules':
    source => 'puppet:///modules/system/disk/schedulers.rules',
  }

}
