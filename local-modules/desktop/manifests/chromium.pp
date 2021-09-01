class desktop::chromium {
  # Chromium/Google Chrome (we use the Flatpak)
  package { ["chromium", "chromium-l10n", "google-chrome-stable"]: ensure => purged }
}
