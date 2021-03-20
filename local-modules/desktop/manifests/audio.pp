class desktop::audio {
  # Configure Pipewire with bluetooth support
  package { ["bluez",
             "bluez-tools",
             "pavucontrol"]:
               ensure => installed
  }
  package { ["pipewire",
             "pipewire-audio-client-libraries"]:
               ensure => installed,
               install_options => ["-t", "experimental"]
  } ->
  file { ["/etc/pipewire/media-session.d/with-pulseaudio",
          "/etc/pipewire/media-session.d/with-alsa",
          "/etc/pipewire/media-session.d/with-jack"]:
            ensure => present,
            content => ""
  } ->
  file { "/etc/alsa/conf.d/99-pipewire-default.conf":
    ensure => link,
    target => "/usr/share/doc/pipewire/examples/alsa.conf.d/99-pipewire-default.conf"
  } ->
  file { "/etc/ld.so.conf.d/pipewire-jack.conf":
    ensure => link,
    target => "/usr/share/doc/pipewire/examples/ld.so.conf.d/pipewire-jack-${facts['platform']}.conf"
  } ~>
  exec { "refresh ldconfig cache":
    command => '/usr/sbin/ldconfig',
    refreshonly => true
  }
}
