class tools::applications {

  package { 'bpftrace': ensure            => installed }
  package { 'git': ensure                 => installed }
  package { 'glances': ensure             => installed }
  package { 'gnupg': ensure               => installed }
  package { 'htop': ensure                => installed }
  package { 'httpie': ensure              => installed }
  package { 'imagemagick': ensure         => installed }
  package { 'ioping': ensure              => installed }
  package { 'iotop': ensure               => installed }
  package { 'less': ensure                => installed }
  package { 'lshw': ensure                => installed }
  package { 'lsof': ensure                => installed }
  package { 'mercurial': ensure           => installed }
  package { 'pass': ensure                => installed }
  package { 'pass-extension-otp': ensure  => installed }
  package { 'pass-extension-tail': ensure => installed }
  package { 'silversearcher-ag': ensure   => installed }
  package { 'strace': ensure              => installed }
  package { 'subversion': ensure          => installed }
  package { 'tmux': ensure                => installed }
  package { 'tzdiff': ensure              => installed }

}
