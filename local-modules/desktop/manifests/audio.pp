class desktop::audio {
  # Configure pulseaudio with bluetooth support
  package { ["bluez",
             "bluez-tools",
             "pavucontrol",
             "pulseaudio",
             "pulseaudio-module-bluetooth"]:
               ensure => installed
  }
}
