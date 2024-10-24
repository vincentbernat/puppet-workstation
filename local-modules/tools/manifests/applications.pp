class tools::applications {

  package { [
             'bpftrace',
             'colordiff',
             'fzf',
             'gcal',
             'gnupg',
             'htop',
             'httpie',
             'hwinfo',
             'hyperfine',
             'imagemagick',
             'ioping',
             'iotop',
             'jq',
             'less',
             'linux-perf',
             'lshw',
             'lsof',
             'magic-wormhole',
             'mmv',
             'moreutils',
             'neofetch',
             'pass',
             'pass-extension-otp',
             'pass-extension-tail',
             'pv',
             'ripgrep',
             'silversearcher-ag',
             'strace',
             'tmux',
             'tzdiff',
             'ugrep',
             ]:
               ensure => installed
  }
  package { "mailcap": ensure => purged }
  package { "linux-headers-${::os['architecture']}":
    ensure => installed }

  package { ['git', 'git-annex', 'git-email']:
    ensure => installed
  } ->
  exec { 'create diff-highlight helper':
    command => '/usr/bin/make',
    cwd     => '/usr/share/doc/git/contrib/diff-highlight',
    creates => '/usr/share/doc/git/contrib/diff-highlight/diff-highlight'
  }
}
