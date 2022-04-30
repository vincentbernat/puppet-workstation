class desktop::audio {
  # Pipewire is pulled from Nix
  package { ["bluez",
             "bluez-tools",
             "pavucontrol"]:
               ensure => installed
  }
  package { ["gstreamer1.0-fdkaac",
             "pulseaudio",
             "pulseaudio-module-bluetooth"]: ensure => purged }
}
