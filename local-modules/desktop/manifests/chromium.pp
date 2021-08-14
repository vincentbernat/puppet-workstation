class desktop::chromium {
  # Chromium
  package { ["chromium", "chromium-l10n"]: ensure => purged }

  # Google Chrome
  apt::source { 'google-chrome':
    location     => 'http://dl.google.com/linux/chrome/deb/',
    release      => 'stable',
    repos        => 'main',
    key          => 'EB4C1BFD4F042F6DDDCCEC917721F63BD38B4796',
    include      => { 'src' => false },
    pin          => 400,
    architecture => 'amd64'
  }
  ->
  package { 'google-chrome-stable': ensure => installed }
}
