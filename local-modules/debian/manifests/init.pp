class debian {

  class { "apt":
    purge => {
      "sources.list"   => true,
      "sources.list.d" => true,
      "preferences"    => true,
      "preferences.d"  => true
    }
  }

  package { ['ubuntu-archive-keyring',
             'debian-keyring',
             'debian-archive-keyring']:
               ensure => installed
  }

  package { ['debian-security-support',
             'debsecan',
             'unattended-upgrades',
             'apt-forktracer']:
             ensure => purged
  }

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
  file { "/etc/apt/trusted.gpg":
    ensure => absent
  }

  apt::source { 'unstable':
    location          => 'http://ftp.fr.debian.org/debian/',
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
  apt::source { 'testing':
    location          => 'http://ftp.fr.debian.org/debian/',
    release           => 'testing',
    repos             => 'main',
  }

  apt::source { 'experimental':
    location => 'http://ftp.fr.debian.org/debian/',
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

  # Do not use pin from apt::source which does use origin instead of release
  apt::pin { ['experimental', 'experimental-debug']:
    priority => 101
  }
  # apt::pin { 'prefer-experimental':
  #   priority => 990,
  #   packages => [
  #   ],
  #   release => "experimental"
  # }

  package { 'flatpak': ensure => installed }
  package { 'needrestart': ensure => installed }
  -> file { '/etc/needrestart/conf.d/puppet.conf':
    content => @(END)
      $nrconf{override_rc}->{q(^bluetooth)} = 0;
      | END
  }

}
