class system::boot {

  # Plymouth theme:
  package { ['plymouth', 'plymouth-themes']:
    ensure => installed
  } ->
  exec { 'unpack plymouth theme':
    require => Package['curl'],
    path    => [ '/sbin', '/bin', '/usr/sbin', '/usr/bin' ],
    creates => '/usr/share/plymouth/themes/glitch/glitch.plymouth',
    command => @(END)
      curl -Ls https://github.com/adi1090x/files/raw/master/plymouth-themes/themes/pack_2/glitch.tar.gz \
        | tar -C /usr/share/plymouth/themes -zxvf -
      | END
  } ->
  exec { 'plymouth-set-default-theme':
    path    => [ '/sbin', '/bin', '/usr/sbin', '/usr/bin' ],
    command => "plymouth-set-default-theme glitch ; update-initramfs -u",
    unless  => "grep -qFx Theme=glitch /etc/plymouth/plymouthd.conf"
  }

  # Grub theme
  package { 'grub-efi-amd64-signed': ensure => absent }
  file { ['/boot/grub/themes', '/boot/grub/themes/fallout']:
    ensure => directory
  } ->
  file { '/etc/default/grub':
    source => 'puppet:///modules/system/grub'
  } ->
  file { ['/boot/grub/.background_cache.png', '/etc/grub.d/05_debian_theme']:
    ensure => absent
  } ->
  exec { 'unpack grub fallout theme':
    require => Package['curl'],
    path    => [ '/sbin', '/bin', '/usr/sbin', '/usr/bin' ],
    creates => '/boot/grub/themes/fallout/theme.txt',
    command => @(END)
      curl -Ls https://github.com/shvchk/fallout-grub-theme/archive/master.tar.gz \
        | tar -C /boot/grub/themes/fallout --strip-components=1 -zxvf -
      update-grub
      | END
  }

  # Console setup
  file { "/etc/default/console-setup":
    source => 'puppet:///modules/system/console-setup'
  }
}
