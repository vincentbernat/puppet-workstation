class system::boot {

  # Plymouth theme
  package { ['plymouth', 'plymouth-themes']:
    ensure => installed
  } ->
  exec { 'unpack plymouth fallout theme':
    path    => [ '/sbin', '/bin', '/usr/sbin', '/usr/bin' ],
    creates => '/usr/share/plymouth/themes/fallout/fallout.plymouth',
    command => @(END)
      curl -Ls https://dllb2.pling.com/api/files/download/id/1536334015/s/c5839b97d39daf8d7f57d3e323827ca9fde18dca954c84e32cf67e1e0d485c1274a91c2c929d5d36e62e0800e8a204d7e91f37ae69b17a4989dbca98e1b0df48/t/1578992005/c/3b20c163f90850c9c92e3e332dee592b931fda1f81c492953300aa31e6d2d038e497140d3fc4cfa75ba4960689756127638697c3d5fb677ca6d806ef55337ea5/lt/download/fallout.tar.xz \
        | tar -C /usr/share/plymouth/themes -Jxvf -
      | END
  } ->
  exec { 'plymouth-set-default-theme':
    path    => [ '/sbin', '/bin', '/usr/sbin', '/usr/bin' ],
    command => "plymouth-set-default-theme fallout ; update-initramfs -u",
    unless  => "grep -qFx Theme=fallout /etc/plymouth/plymouthd.conf"
  }

  # Grub theme
  package { 'grub-efi-amd64-signed': ensure => absent }
  file { ['/boot/grub/themes', '/boot/grub/themes/fallout']:
    ensure => directory
  } ->
  file { '/etc/default/grub':
    source => 'puppet:///modules/system/grub'
  } ->
  file { '/boot/grub/.background_cache.png':
    ensure => absent
  } ->
  exec { 'unpack grub fallout theme':
    path    => [ '/sbin', '/bin', '/usr/sbin', '/usr/bin' ],
    creates => '/boot/grub/themes/fallout/theme.txt',
    command => @(END)
      curl -Ls https://github.com/shvchk/fallout-grub-theme/archive/master.tar.gz \
        | tar -C /boot/grub/themes/fallout --strip-components=1 -zxvf -
      update-grub
      | END
  }
}
