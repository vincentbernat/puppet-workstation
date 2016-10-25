class debian {

  package { ['ubuntu-archive-keyring',
             'debian-keyring',
             'debian-archive-keyring',
             'apt-transport-https']:
               ensure => installed
  }

  package { 'debian-security-support': ensure => installed }
  package { 'apt-forktracer': ensure => installed }
  package { "aptitude": ensure => installed } ->
  file { "/etc/apt/apt.conf.d/25aptitude":
    source => "puppet:///modules/debian/apt/25aptitude"
  }
  file { "/etc/apt/apt.conf.d/02periodic":
    source => "puppet:///modules/debian/apt/02periodic"
  }
  file { "/etc/apt/apt.conf.d/10disable-pdiff":
    ensure => absent
  }
  file { "/etc/apt/apt.conf.d/99translations":
    source => "puppet:///modules/debian/apt/99translations"
  }

  apt::source { 'unstable':
    location          => 'https://deb.debian.org/debian/',
    release           => 'unstable',
    repos             => 'main contrib non-free',
    include           => { 'src' => true }
  }
  apt::source { 'unstable-debug':
    location => "https://deb.debian.org/debian-debug/",
    release  => "unstable-debug",
    repos    => 'main',
    include  => { 'src' => false }
  }

  apt::source { 'experimental':
    location => 'https://deb.debian.org/debian/',
    release  => 'experimental',
    repos    => 'main',
    include  => { 'src' => false }
  }
  apt::source { 'experimental-debug':
    location => "https://deb.debian.org/debian-debug/",
    release  => "experimental-debug",
    repos    => 'main',
    include  => { 'src' => false }
  }

  apt::pin { ['experimental', 'experimental-debug']:
    priority => 101
  }

  # Enable multiarch
  if $::architecture == 'amd64' {
    exec { '/usr/bin/dpkg --add-architecture i386':
      notify => Exec['apt_update'],
      unless => '/usr/bin/dpkg --print-foreign-architectures | /bin/grep -qFx i386'
    }
  }

}
