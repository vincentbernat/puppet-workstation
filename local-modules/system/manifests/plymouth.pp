class system::plymouth {

  package { ["plymouth", "plymouth-themes"]:
    ensure => installed
  }

  $theme = "futureprototype"
  exec { "plymouth-set-default-theme":
    path    => [ "/sbin", "/bin", "/usr/sbin", "/usr/bin" ],
    command => "plymouth-set-default-theme ${theme} ; update-initramfs -u",
    unless  => "grep -qFx Theme=${theme} /etc/plymouth/plymouthd.conf"
  }

  kernel_parameter { "splash":
    provider => "grub2",
    ensure   => present
  }

}
