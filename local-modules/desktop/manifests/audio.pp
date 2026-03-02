class desktop::audio {
  package { ["bluez",
             "bluez-tools",
             "rtkit",
             "speech-dispatcher",
             "pulseaudio-utils",
             "pavucontrol"]:
               ensure => installed
  } -> service { "rtkit-daemon":
    ensure => running,
    enable => true
  } -> file_line { "enable Bluetooth D-Bus interface":
    ensure => present,
    line   => 'Experimental = true',
    match  => '^#?Experimental = .*',
    path   => '/etc/bluetooth/main.conf',
  } -> file_line { "enable ISO interface":
    ensure => present,
    line   => 'KernelExperimental = 6fbaf188-05e0-496a-9885-d6ddfdb4e03e',
    match  => '^#?KernelExperimental = .*',
    path   => '/etc/bluetooth/main.conf',
  } ~> service { "bluetooth": }

  package { ["gstreamer1.0-fdkaac",
             "pulseaudio",
             "pulseaudio-module-bluetooth"]: ensure => purged }
  # pipewire is pulled from Nix (to get the appropriate Bluetooth codecs)
  package { ["pipewire",
             "pipewire-pulse",
             "wireplumber"]: ensure => purged }
}
