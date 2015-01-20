class applications {

  package { "bmon": ensure => installed }
  package { "curl": ensure => installed }
  package { "git": ensure => installed }
  package { "glances": ensure => installed }
  package { "gnupg": ensure => installed }
  package { "htop": ensure => installed }
  package { "httpie": ensure => installed }
  package { "imagemagick": ensure => installed }
  package { "ioping": ensure => installed }
  package { "iotop": ensure => installed }
  package { "less": ensure => installed }
  package { "lftp": ensure => installed }
  package { "lldpd": ensure => installed }
  package { "lshw": ensure => installed }
  package { "lsof": ensure => installed }
  package { "mercurial": ensure => installed }
  package { "mtr-tiny": ensure => installed }
  package { "openssh-client": ensure => installed }
  package { "snmp": ensure => installed } ->
  package { "snmp-mibs-downloader": ensure => installed }
  package { "strace": ensure => installed }
  package { "subversion": ensure => installed }
  package { "tcpdump": ensure => installed }
  package { "tmux": ensure => installed }
  package { "traceroute": ensure => installed }
  package { "wget": ensure => installed }

}
