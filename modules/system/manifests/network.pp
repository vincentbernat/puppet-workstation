class network {

  # For networking, we rely on network manager.
  package { "resolvconf": ensure => installed }
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

  file { "/etc/network/interfaces":
    source => "puppet:///modules/system/network/interfaces"
  }
}
