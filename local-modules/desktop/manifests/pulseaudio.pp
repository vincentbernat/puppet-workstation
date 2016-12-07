class desktop::pulseaudio {
  # Configure pulseaudio with bluetooth support
  package { "bluez": ensure => installed } ->
  package { "bluez-tools": ensure => installed }

  package { "pulseaudio": ensure => installed } ->
  package { "pulseaudio-module-bluetooth": ensure => installed } ->
  file_line { 'pulseaudio flat volumes':
    ensure => present,
    line   => 'flat-volumes = no',
    match  => '^[; ]*flat-volumes = .',
    path   => '/etc/pulse/daemon.conf'
  }

  package { "pavucontrol": ensure => installed }

}
