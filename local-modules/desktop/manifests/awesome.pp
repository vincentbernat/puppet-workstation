class desktop::awesome {
  package { "awesome": ensure => held }
  package { "awesome-extra": ensure => held }

  package { "alsa-utils": ensure => installed }
  package { "compton": ensure => installed }
  package { "dconf-cli": ensure => installed }
  package { "fvwm": ensure => installed }
  package { "fvwm-crystal": ensure => installed }
  package { "gconf2": ensure => installed }
  package { "gnome-icon-theme": ensure => installed }
  package { "gnome-icon-theme-symbolic": ensure => installed }
  package { "gnome-themes-standard": ensure => installed }
  package { "gnupg-agent": ensure => installed }
  package { "hsetroot": ensure => installed }
  package { "i3lock": ensure => installed }
  package { "inputplug": ensure => installed }
  package { "libnotify-bin": ensure => installed }
  package { "libvte-2.91-0": ensure => installed }
  package { "numlockx": ensure => installed }
  package { "policykit-1-gnome": ensure => installed }
  package { "python-imaging": ensure => installed }
  package { "python-xpyb": ensure => installed }
  package { "redshift": ensure => installed }
  package { "x11-xkb-utils": ensure => installed }
  package { "x11-xserver-utils": ensure => installed }
  package { "xss-lock": ensure => installed }
  package { "xbacklight": ensure => installed }
  package { "xdg-utils": ensure => installed }
  package { "xfce4-terminal": ensure => installed }
  package { "xinput": ensure => installed }
  package { "xsel": ensure => installed }
  package { "xsettingsd": ensure => installed }
}
