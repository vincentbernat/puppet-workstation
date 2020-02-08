#
# Dynamic DNS update using Route53
#
class system::network::ddns($key, $secret, $domain, $ttl=60) {

  file { "/usr/local/bin/ddns-updater":
    content => template("system/network/ddns-updater.erb"),
    owner => root,
    mode => "0700"
  }

  $mstart = fqdn_rand(15)
  $sleep = fqdn_rand(40)
  cron { "ddns-updater":
    command => "/bin/sleep ${sleep} ; [ x`/usr/bin/nmcli networking connectivity` != xfull ] || /usr/local/bin/ddns-updater --ipv6=public",
    minute => "${mstart}-59/15",
    require => File['/usr/local/bin/ddns-updater']
  }

  file { '/etc/dhcp/dhclient-exit-hooks.d/ddns-updater':
    source => "puppet:///modules/system/network/dhcp-hook"
  }

  ensure_resource(
    package,
    'python3-boto',
    { ensure => present })

}
