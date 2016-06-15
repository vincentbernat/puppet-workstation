class desktop::pulseaudio {
  # Configure pulseaudio with bluetooth support
  package { "bluez": ensure => installed } ->
  package { "bluez-tools": ensure => installed }

  package { "pulseaudio": ensure => installed } ->
  package { "pulseaudio-module-bluetooth": ensure => installed }

  package { "pavucontrol": ensure => installed }
}
