class desktop::chromium {
  package { ["chromium", "chromium-l10n"]: ensure => installed }
  ->
  package { ["google-chrome-beta", "google-talkplugin"]: ensure => purged }
}
