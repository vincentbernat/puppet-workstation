class plymouth {

  package { ["plymouth", "plymouth-themes"]:
    ensure => installed
  }

  exec { "plymouth-set-default-theme":
    path => [ "/sbin", "/bin", "/usr/sbin", "/usr/bin" ],
    command => "plymouth-set-default-theme solar ; update-initramfs -u",
    unless => "grep -qFx Theme=solar /etc/plymouth/plymouthd.conf"
  }

  kernel_parameter { "splash":
    provider => "grub2",
    ensure => present
  }

}
