class system::network {

  # For networking, we rely on network manager.
  package { "network-manager": ensure => installed }
  package { "network-manager-gnome": ensure => installed }
  package { "network-manager-openvpn": ensure => installed }
  package { "network-manager-openvpn-gnome": ensure => installed }
  package { "wireguard": ensure => installed }

  # Enable dnsmasq
  package { "resolvconf": ensure => purged }
  ->
  package { "dnsmasq-base": ensure => installed }
  ->
  package { "dnsmasq": ensure => purged }

  file { "/etc/network/interfaces":
    source => "puppet:///modules/system/network/interfaces"
  }

  # Make firewalld uses iptables (compat with Docker)
  package { "firewall-applet": ensure => installed }
  package { "firewalld": ensure => installed }
  ->
  file_line { 'firewalld uses iptables':
    ensure => present,
    line   => "FirewallBackend=iptables",
    match  => "^[# ]*FirewallBackend=",
    path   => '/etc/firewalld/firewalld.conf'
  }
  ~>
  service { "firewalld":
    ensure => running,
    enable => true
  }

  file { "/etc/NetworkManager/NetworkManager.conf":
    require => Package["network-manager"],
    source => "puppet:///modules/system/network/NetworkManager.conf"
  }

  include system::network::ddns

}
