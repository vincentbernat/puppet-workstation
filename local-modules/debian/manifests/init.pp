class debian {

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
    source => "puppet:///modules/debian/apt/10disable-pdiff"
  }
  file { "/etc/apt/apt.conf.d/99translations":
    source => "puppet:///modules/debian/apt/99translations"
  }

  apt::source { 'unstable':
    location          => 'http://cloudfront.debian.net/debian/',
    release           => 'unstable',
    repos             => 'main contrib non-free',
    required_packages => 'debian-keyring debian-archive-keyring',
    include_src       => true
  }
  apt::source { 'unstable-debug':
    location    => "http://debug.mirrors.debian.org/debian-debug/",
    release     => "unstable-debug",
    repos       => 'main',
    include_src => false
  }

  apt::source { 'experimental':
    location    => 'http://cloudfront.debian.net/debian/',
    release     => 'experimental',
    repos       => 'main',
    include_src => false
  }
  apt::source { 'experimental-debug':
    location    => "http://debug.mirrors.debian.org/debian-debug/",
    release     => "experimental-debug",
    repos       => 'main',
    include_src => false
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
