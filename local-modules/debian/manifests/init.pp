class debian {

  package { ['ubuntu-archive-keyring',
             'debian-keyring',
             'debian-archive-keyring']:
               ensure => installed
  }

  package { 'debian-security-support': ensure => purged }
  package { 'apt-forktracer': ensure => installed }
  package { "aptitude": ensure => installed } ->
  file { "/etc/apt/apt.conf.d/25aptitude":
    source => "puppet:///modules/debian/apt/25aptitude"
  }
  file { "/etc/apt/apt.conf.d/02periodic":
    source => "puppet:///modules/debian/apt/02periodic"
  }
  file { "/etc/apt/apt.conf.d/99translations":
    source => "puppet:///modules/debian/apt/99translations"
  }

  apt::source { 'unstable':
    location          => 'http://httpredir.debian.org/debian/',
    release           => 'unstable',
    repos             => 'main contrib non-free',
    include           => { 'src' => true }
  }
  apt::source { 'unstable-debug':
    location => "http://debug.mirrors.debian.org/debian-debug/",
    release  => "unstable-debug",
    repos    => 'main',
    include  => { 'src' => false }
  }

  apt::source { 'experimental':
    location => 'http://httpredir.debian.org/debian/',
    release  => 'experimental',
    repos    => 'main contrib non-free',
    include  => { 'src' => true }
  }
  apt::source { 'experimental-debug':
    location => "http://debug.mirrors.debian.org/debian-debug/",
    release  => "experimental-debug",
    repos    => 'main',
    include  => { 'src' => false }
  }

  apt::pin { ['experimental', 'experimental-debug']:
    priority => 101
  }

  package { 'flatpak': ensure => installed }

}
