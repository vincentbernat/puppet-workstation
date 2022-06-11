class desktop::audio {
  # Pipewire is pulled from Nix
  package { ["bluez",
             "bluez-tools",
             "rtkit",
             "pavucontrol"]:
               ensure => installed
  } -> service { "rtkit-daemon":
    ensure => running,
    enable => true
  }
  package { ["gstreamer1.0-fdkaac",
             "pulseaudio",
             "pulseaudio-module-bluetooth"]: ensure => purged }
}
