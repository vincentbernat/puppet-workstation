class desktop::x11 {

  package { ['xserver-xorg',
             'xserver-xorg-input-evdev',
             'xserver-xorg-input-libinput',
             'va-driver-all']: ensure => installed }
  package { ['xserver-xorg-input-synaptics',
             'xserver-xorg-legacy',
             'libvdpau-va-gl1']: ensure => absent }

  package { 'lightdm': ensure => installed }
  ->
  package { 'lightdm-gtk-greeter': ensure => installed }
  ->
  file { '/etc/lightdm/lightdm.conf':
    content => template('desktop/x11/lightdm.conf.erb')
  }
  ~>
  service { 'lightdm':
    ensure => running,
    restart => 'service lightdm reload'
  }

}
