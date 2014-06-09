class x11 {

  package { "xserver-xorg": ensure => installed }
  ->
  file { "/etc/X11/xorg.conf.d":
    ensure => directory
  }
  file { "/etc/X11/xorg.conf.d/10-keyboard.conf":
    require => File["/etc/X11/xorg.conf.d"],
    source => "puppet:///modules/desktop/x11/keyboard.conf"
  }
  file { "/etc/X11/xorg.conf.d/20-mouse.conf":
    require => File["/etc/X11/xorg.conf.d"],
    source => "puppet:///modules/desktop/x11/mouse.conf"
  }
  file { "/usr/share/X11/xkb/symbols/vbe":
    require => File["/etc/X11/xorg.conf.d"],
    source => "puppet:///modules/desktop/x11/vbe"
  }
  file { "/usr/share/X11/xkb/rules/vbe":
    require => File["/etc/X11/xorg.conf.d"],
    source => "/usr/share/X11/xkb/rules/evdev"
  }

  # That's unfortunate, but we have to modify this file to get what we want...
  define evdev_add_option($option, $symbols) {
    file_line { "evdev_option_${option}":
      after => "! option	=	symbols",
      line => "  ${option} = ${symbols}",
      path => "/usr/share/X11/xkb/rules/evdev",
      require => Package["xserver-xorg"],
      notify => File["/usr/share/X11/xkb/rules/vbe"]
    }
  }
  evdev_add_option { "vbe_pause":
    option => "vbe:pause",
    symbols => "+vbe(pause)"
  }

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
