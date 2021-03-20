class desktop::audio {
  # Configure pulseaudio with bluetooth support
  package { ["bluez",
             "bluez-tools",
             "pavucontrol",
             "pulseaudio",
             "pulseaudio-module-bluetooth"]:
               ensure => installed
  }
  package { ["pipewire",
             "pipewire-audio-client-libraries"]:
               ensure => purged
  }
  file { "/etc/alsa/conf.d/99-pipewire-default.conf":
    ensure => absent,
  }
  file { "/etc/ld.so.conf.d/pipewire-jack.conf":
    ensure => absent
  }
}
