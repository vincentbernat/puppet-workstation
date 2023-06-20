class system::network {

  # For networking, we rely on network manager.
  package { ["network-manager",
             "network-manager-gnome"]:
               ensure => installed
  }
  ->
  package { ["modemmanager",
             "ifupdown"]:
               ensure => purged
  }
  package { "wireguard": ensure => installed }

  # DNS
  package { "libnss-resolve": ensure => installed }
  package { "resolvconf":     ensure => purged }
  package { "dnsmasq":        ensure => purged }
  package { "dnsmasq-base":   ensure => installed }
  package { "systemd-resolved": ensure => installed }
  ->
  service { "systemd-resolved":
    ensure => running,
    enable => true
  }
  ->
  file { "/etc/resolv.conf":
    ensure => link,
    target => "../run/systemd/resolve/stub-resolv.conf"
  }

  file { "/etc/network/interfaces":
    source => "puppet:///modules/system/network/interfaces"
  }

  package { ["firewall-applet",
             "firewalld",
             "nftables"]: ensure => installed }
  ->
  file_line { 'firewalld uses nftables':
    ensure => present,
    line   => "FirewallBackend=nftables",
    match  => "^[# ]*FirewallBackend=",
    path   => '/etc/firewalld/firewalld.conf'
  }
  ~>
  service { "firewalld":
    ensure => running,
    enable => true
  }

  file { "/etc/NetworkManager/NetworkManager.conf":
    require => [ Package["network-manager"],
                 File["/etc/resolv.conf"] ],
    source => "puppet:///modules/system/network/NetworkManager.conf"
  }
  ~>
  service { "NetworkManager":
    ensure => running,
    enable => true
  }

  include system::network::ddns

}
