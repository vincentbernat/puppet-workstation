class desktop::x11 {

  package { ['xserver-xorg',
             'xserver-xorg-input-evdev',
             'xserver-xorg-input-libinput',
             'va-driver-all']: ensure => installed }
  package { ['xserver-xorg-input-synaptics',
             'xserver-xorg-legacy',
             'libvdpau-va-gl1']: ensure => absent }

  package { ['lightdm', 'lightdm-gtk-greeter']: ensure => purged }
  package { 'xinit': ensure => installed }
  ->
  file { '/etc/systemd/system/startx.service':
    content => template('desktop/x11/startx.service.erb')
  }
  ->
  service { 'startx':
    enable => true
  }
}
