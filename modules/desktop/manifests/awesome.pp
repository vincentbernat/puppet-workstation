class awesome {
  package { "awesome": ensure => installed }
  package { "awesome-extra": ensure => installed }

  package { "compton": ensure => installed }
  package { "dconf-cli": ensure => installed }
  package { "fvwm": ensure => installed }
  package { "fvwm-crystal": ensure => installed }
  package { "i3lock": ensure => installed }
  package { "gconf2": ensure => installed }
  package { "gnome-themes-standard": ensure => installed }
  package { "gnupg-agent": ensure => installed }
  package { "hsetroot": ensure => installed }
  package { "numlockx": ensure => installed }
  package { "policykit-1-gnome": ensure => installed }
  package { "redshift": ensure => installed }
  package { "x11-xkb-utils": ensure => installed }
  package { "x11-xserver-utils": ensure => installed }
  package { "xautolock": ensure => installed }
  package { "xdg-utils": ensure => installed }
  package { "xinput": ensure => installed }
}
