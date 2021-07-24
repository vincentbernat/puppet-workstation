class desktop::audio {
  # Configure pipewire with bluetooth support
  package { ["bluez",
             "bluez-tools",
             "pavucontrol",
             "pipewire",
             "pipewire-pulse",
             "pipewire-audio-client-libraries",
             "libspa-0.2-bluetooth"]:
               ensure => installed
  }
  package { "pulseaudio-module-bluetooth": ensure => purged }
}
