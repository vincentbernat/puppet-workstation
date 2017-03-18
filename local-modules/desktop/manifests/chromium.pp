class desktop::chromium {

  package { ["chromium", "chromium-l10n"]: ensure => installed }
  ->
  apt::source { 'google-chrome-beta':
    location     => 'http://dl.google.com/linux/chrome/deb/',
    release      => 'stable',
    repos        => 'main',
    key          => '9534C9C4130B4DC9927992BF4F30B6B4C07CB649',
    include      => { 'src' => false },
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
  package { 'google-talkplugin': ensure => absent }

}
