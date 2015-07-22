class network {

  package { "bmon": ensure => installed }
  package { "curl": ensure => installed }
  package { "lftp": ensure => installed }
  package { "lldpd": ensure => installed }
  package { "mtr-tiny": ensure => installed }
  package { "openssh-client": ensure => installed }
  package { "oping": ensure => installed }
  package { "snmp": ensure => installed } ->
  package { "snmp-mibs-downloader": ensure => installed }
  package { "tcpdump": ensure => installed }
  package { "traceroute": ensure => installed }
  package { "tshark": ensure => installed }
  package { "wget": ensure => installed }

}
