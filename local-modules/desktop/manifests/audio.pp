class desktop::audio {
  # Configure pulseaudio with bluetooth support
  package { ["bluez",
             "bluez-tools",
             "pavucontrol",
             "gst-plugins-bad1.0-contrib", # AAC support because #981285 in Debian
             "pulseaudio",
             "pulseaudio-module-bluetooth"]:
               ensure => installed
  }
  package { "pipewire": ensure => purged }
}
