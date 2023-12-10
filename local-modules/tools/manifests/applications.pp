class tools::applications {

  package { [
             'ansifilter',
             'bpftrace',
             'bpytop',
             'colordiff',
             'fzf',
             'gcal',
             'glances',
             'fd-find',
             'gnupg',
             'htop',
             'httpie',
             'hwinfo',
             'imagemagick',
             'ioping',
             'iotop',
             'jq',
             'less',
             'linux-perf',
             'lshw',
             'lsof',
             'magic-wormhole',
             'mercurial',
             'mmv',
             'moreutils',
             'neofetch',
             'pass',
             'pass-extension-otp',
             'pass-extension-tail',
             'pv',
             'recollcmd',
             'ripgrep',
             'silversearcher-ag',
             'strace',
             'subversion',
             'tmux',
             'tzdiff',
             'urlscan',
             ]:
               ensure => installed
  }
  ->
  service { "glances":
    ensure => stopped,
    enable => false
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
