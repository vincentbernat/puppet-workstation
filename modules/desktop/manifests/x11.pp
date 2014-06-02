class x11 {

  package { "xserver-xorg": ensure => installed }

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
