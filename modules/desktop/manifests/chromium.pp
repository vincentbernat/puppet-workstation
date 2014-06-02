class chromium {

  package { "chromium": ensure => installed }
  ->
  apt::source { 'google-chrome-beta':
    location    => 'http://dl.google.com/linux/chrome/deb/',
    release     => 'stable',
    repos       => 'main',
    key         => '7FAC5991',
    key_server  => 'subkeys.pgp.net',
    include_src => false
  }
  ->
  package { 'google-chrome-beta': ensure => installed }
  ->
  file { '/etc/chromium/default':
    source => "puppet:///modules/desktop/chromium/default"
  }

}
