#
# Dynamic DNS update using Route53
#
class system::network::ddns($key, $secret, $domain, $ttl=60) {

  file { "/usr/local/bin/ddns-updater":
    content => template("system/network/ddns-updater.erb"),
    owner => root,
    mode => "0700"
  }

  cron { "ddns-updater":
    command => "/usr/local/bin/ddns-updater",
    minute => '*/10',
    require => File['/usr/local/bin/ddns-updater']
  }

  file { '/etc/dhcp/dhclient-exit-hooks.d/ddns-updater':
    ensure => link,
    target => "/usr/local/bin/ddns-updater"
  }

  ensure_resource(
    package,
    'python-boto',
    { ensure => present })

}
