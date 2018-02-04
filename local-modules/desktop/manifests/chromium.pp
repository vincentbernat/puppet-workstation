class desktop::chromium {
  package { ["chromium", "chromium-l10n"]: ensure => installed }
  ->
  package { ["google-chrome-beta", "google-talkplugin"]: ensure => purged }
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
}
