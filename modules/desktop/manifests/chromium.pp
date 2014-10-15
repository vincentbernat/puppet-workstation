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
  file { '/etc/chromium.d/flash':
    source => "puppet:///modules/desktop/chromium/flash",
  }
  file { '/etc/chromium.d/googleapikeys':
    source => "puppet:///modules/desktop/chromium/googleapikeys"
  }
  file { '/etc/chromium.d/tls':
    source => "puppet:///modules/desktop/chromium/tls"
  }
  file { '/etc/chromium.d':
    ensure => directory
  }

}
