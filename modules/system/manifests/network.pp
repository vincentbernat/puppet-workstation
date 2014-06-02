class network {

  # For networking, we rely on network manager.
  package { "resolvconf": ensure => installed }
  package { "network-manager": ensure => installed }
  package { "network-manager-gnome": ensure => installed }
  package { "network-manager-openvpn": ensure => installed }
  package { "network-manager-openvpn-gnome": ensure => installed }

  file { "/etc/network/interfaces":
    source => "puppet:///modules/system/network/interfaces"
  }
}
