class desktop::audio {
  # Configure pipewire with bluetooth support
  package { ["bluez",
             "bluez-tools",
             "pavucontrol",
             "gstreamer1.0-fdkaac",
             "pipewire",
             "pipewire-pulse",
             "pipewire-audio-client-libraries",
             "wireplumber",
             "libspa-0.2-bluetooth"]:
               ensure => installed
  }
  package { ["pipewire-media-session",
             "pulseaudio-module-bluetooth",
             "pulseaudio"]:
               ensure => purged
  }
}
