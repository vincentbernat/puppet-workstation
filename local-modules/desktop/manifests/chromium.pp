class desktop::chromium {
  # Chromium
  package { ["chromium", "chromium-l10n"]: ensure => purged }

  # Google Chrome
  package { 'google-chrome-stable': ensure => installed }
}
