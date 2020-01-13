class system::plymouth {

  # Plymouth theme
  package { ['plymouth', 'plymouth-themes']:
    ensure => installed
  }
  $theme = 'futureprototype'
  exec { 'plymouth-set-default-theme':
    path    => [ '/sbin', '/bin', '/usr/sbin', '/usr/bin' ],
    command => "plymouth-set-default-theme ${theme} ; update-initramfs -u",
    unless  => "grep -qFx Theme=${theme} /etc/plymouth/plymouthd.conf"
  }

  # Grub theme
  file { ['/boot/grub/themes', '/boot/grub/themes/fallout']:
    ensure => directory
  } ->
  exec { 'unpack fallout theme':
    path    => [ '/sbin', '/bin', '/usr/sbin', '/usr/bin' ],
    creates => '/boot/grub/themes/fallout/theme.txt',
    command => @(END)
      curl -Ls https://github.com/shvchk/fallout-grub-theme/archive/master.tar.gz \
        | tar -C /boot/grub/themes/fallout --strip-components=1 -zxvf -
      | END
  } ->
  file { '/etc/default/grub':
    source => 'puppet:///modules/system/grub'
  } ~>
  exec { 'update-grub':
    command     => '/sbin/update-grub',
    refreshonly => true
  }

}
