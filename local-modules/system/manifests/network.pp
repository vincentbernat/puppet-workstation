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
  package { "dnsmasq-base": ensure => installed }
  ->
  package { "dnsmasq": ensure => purged }

  file { "/etc/network/interfaces":
    source => "puppet:///modules/system/network/interfaces"
  }

  file { "/etc/NetworkManager/NetworkManager.conf":
    require => Package["network-manager"],
    source => "puppet:///modules/system/network/NetworkManager.conf"
  }

  # Don't autosuspend Thinkpad Dock Giga
  udev::rule { "90-no-autosuspend-thinkpad-dock-giga.rules":
    source => 'puppet:///modules/system/network/no-autosuspend-thinkpad-dock-giga.rules'
  }

  include system::network::ddns

}
