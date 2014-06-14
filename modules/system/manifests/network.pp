class network {

  # For networking, we rely on network manager.
  package { "network-manager": ensure => installed }
  package { "network-manager-gnome": ensure => installed }
  package { "network-manager-openvpn": ensure => installed }
  package { "network-manager-openvpn-gnome": ensure => installed }
  package { "network-manager-openconnect": ensure => installed }
  package { "network-manager-openconnect-gnome": ensure => installed }
  package { "network-manager-pptp": ensure => installed }
  package { "network-manager-pptp-gnome": ensure => installed }
  package { "network-manager-vpnc": ensure => installed }
  package { "network-manager-vpnc-gnome": ensure => installed }
  package { "firewall-applet": ensure => installed }
  package { "firewalld": ensure => installed }

  # Enable dnsmasq
  package { "resolvconf": ensure => purged }
  ->
  package { "dnsmasq": ensure => installed }
  ->
  service { "dnsmasq":
    ensure => stopped,
    enable => false
  }
  file_line { "disable_dnsmasq":
    line => "ENABLED=0",
    match => "ENABLED=.",
    path => "/etc/default/dnsmasq"
  }
  ->
  file_line { "networkmanager_dnsmasq":
    after => "\\[main\\]",
    line => "dns=dnsmasq",
    path => "/etc/NetworkManager/NetworkManager.conf"
  }

  file { "/etc/network/interfaces":
    source => "puppet:///modules/system/network/interfaces"
  }
}
