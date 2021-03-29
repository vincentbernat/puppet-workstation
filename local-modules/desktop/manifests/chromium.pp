class desktop::chromium {
  # Chromium
  package { ["chromium", "chromium-l10n"]: ensure => installed }

  # Google Chrome
  apt::source { 'google-chrome':
    location     => 'http://dl.google.com/linux/chrome/deb/',
    release      => 'stable',
    repos        => 'main',
    key          => '9534C9C4130B4DC9927992BF4F30B6B4C07CB649',
    include      => { 'src' => false },
    pin          => 400,
    architecture => 'amd64'
  }
  ->
  package { 'google-chrome-stable': ensure => installed }
}
