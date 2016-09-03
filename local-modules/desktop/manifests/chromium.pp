class desktop::chromium {

  package { ["chromium", "chromium-l10n"]: ensure => installed }
  ->
  apt::source { 'google-chrome-beta':
    location     => 'http://dl.google.com/linux/chrome/deb/',
    release      => 'stable',
    repos        => 'main',
    key          => '4CCA1EAF950CEE4AB83976DCA040830F7FAC5991',
    key_server   => 'subkeys.pgp.net',
    include_src  => false,
    pin          => 400,
    architecture => 'amd64'
  }
  ->
  package { 'google-chrome-beta': ensure => installed }
  ->
  file { '/etc/chromium.d':
    ensure  => directory,
    recurse => true,
    purge   => true,
    source => "puppet:///modules/desktop/chromium"
  }
  ->
  file { '/etc/chromium.d/apikeys':
    # Provided with Debian package, leave as is
    ensure => present
  }

  /* Hangout */
  apt::source { 'google-talkplugin':
    location     => 'http://dl.google.com/linux/talkplugin/deb/',
    release      => 'stable',
    repos        => 'main',
    key          => '4CCA1EAF950CEE4AB83976DCA040830F7FAC5991',
    key_server   => 'subkeys.pgp.net',
    include_src  => false,
    pin          => 400,
    architecture => 'amd64'
  }
  ->
  package { 'google-talkplugin': ensure => installed }

}
