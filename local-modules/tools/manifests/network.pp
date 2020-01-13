class tools::network {

  package { 'bmon':                 ensure => installed }
  package { 'curl':                 ensure => installed }
  package { 'ethtool':              ensure => installed }
  package { 'fping':                ensure => installed }
  package { 'gnutls-bin':           ensure => installed }
  package { 'httping':              ensure => installed }
  package { 'ldnsutils':            ensure => installed }
  package { 'lftp':                 ensure => installed }
  package { 'lldpd':                ensure => installed }
  package { 'mtr-tiny':             ensure => installed }
  package { 'netcat':               ensure => installed }
  package { 'openssh-client':       ensure => installed }
  package { 'oping':                ensure => installed }
  package { 'snmp':                 ensure => installed } ->
  package { 'snmp-mibs-downloader': ensure => installed }
  package { 'tcpdump':              ensure => installed }
  package { 'traceroute':           ensure => installed }
  package { 'tshark':               ensure => installed }
  package { 'wget':                 ensure => installed }
  package { 'whois':                ensure => installed }

}
