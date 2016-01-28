class x11 {

  package { ["xserver-xorg",
             "xserver-xorg-video-all",
             "xserver-xorg-video-intel",
             "xserver-xorg-input-all",
             "xserver-xorg-input-evdev"]: ensure => installed }

  package { "lightdm": ensure => installed }
  ->
  package { "lightdm-gtk-greeter": ensure => installed }
  ->
  file { "/etc/lightdm/lightdm.conf":
    content => template("desktop/x11/lightdm.conf.erb")
  }
  ~>
  service { "lightdm":
    ensure => running,
    restart => "service lightdm reload"
  }

}
