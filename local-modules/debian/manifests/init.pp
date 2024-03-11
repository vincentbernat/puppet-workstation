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
    content => @(END)
      Aptitude::Always-Use-Safe-Resolver "true";
      Aptitude::ProblemResolver {
        SolutionCost "priority, removals, canceled-actions";
      }
      | END
  }
  file { "/etc/apt/apt.conf.d/02periodic":
    content => @(END)
      // Autoclean
      APT::Periodic::MinAge "1";
      APT::Periodic::AutocleanInterval "1";
      | END
  }
  file { "/etc/apt/apt.conf.d/02nopdiff":
    content => @(END)
      // Disable pdiffs
      Acquire::PDiffs "false";
      | END
  }
  file { "/etc/apt/apt.conf.d/99translations":
    content => @(END)
      // Disable translations
      Acquire::Languages "none";
      | END
  }
  file { "/etc/apt/trusted.gpg":
    ensure => absent
  }

  apt::source { 'unstable':
    location          => 'http://deb.debian.org/debian/',
    release           => 'unstable',
    repos             => 'main contrib non-free non-free-firmware',
    include           => { 'src' => true }
  }
  apt::source { 'unstable-debug':
    location => "http://debug.mirrors.debian.org/debian-debug/",
    release  => "unstable-debug",
    repos    => 'main',
    include  => { 'src' => false }
  }
  apt::source { 'testing':
    location          => 'http://deb.debian.org/debian/',
    release           => 'testing',
    repos             => 'main',
  }

  apt::source { 'experimental':
    location => 'http://deb.debian.org/debian/',
    release  => 'experimental',
    repos    => 'main',
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
