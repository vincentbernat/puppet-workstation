class chromium {

  package { "chromium": ensure => installed }
  ->
  apt::source { 'google-chrome-beta':
    location    => 'http://dl.google.com/linux/chrome/deb/',
    release     => 'stable',
    repos       => 'main',
    key         => '7FAC5991',
    key_server  => 'subkeys.pgp.net',
    include_src => false,
    pin         => 400
  }
  ->
  package { 'google-chrome-beta': ensure => installed }
  ->
  file { '/etc/chromium.d/flash':
    ensure => absent
  }
  file { '/etc/chromium.d/googleapikeys':
    ensure => absent
  }
  file { '/etc/chromium.d/bts-783858':
    ensure => absent
  }
  file { '/etc/chromium.d/tls':
    source => "puppet:///modules/desktop/chromium/tls"
  }
  file { '/etc/chromium.d/scale-factor':
    source => "puppet:///modules/desktop/chromium/scale-factor"
  }
  file { '/etc/chromium.d':
    ensure => directory
  }

}
