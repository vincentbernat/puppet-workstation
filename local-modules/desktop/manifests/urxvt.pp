class urxvt {
  package { "rxvt-unicode-256color": ensure => installed }
  package { "rxvt-unicode": ensure => absent }
}
