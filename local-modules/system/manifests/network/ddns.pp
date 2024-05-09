#
# Dynamic DNS update using Route53
#
class system::network::ddns($key=undef, $secret=undef, $domain=undef, $ttl=60) {

  if $domain != undef {
    file { "/usr/local/bin/ddns-updater":
      content => template("system/network/ddns-updater.erb"),
      owner => root,
      mode => "0700"
    }

    cron { "ddns-updater":
      ensure => absent
    }
    systemd::timer{ 'ddns-updater.timer':
      service_unit => 'ddns-updater.service',
      require => File['/usr/local/bin/ddns-updater'],
      active => true,
      enable => true,
      timer_content => @(END)
        [Timer]
        OnUnitActiveSec=15m
        OnBootSec=30s
        RandomizedDelaySec=60s

        [Install]
        WantedBy=timers.target
        | END
      ,
      service_content => @(END)
        [Service]
        Type=oneshot
        ExecCondition=sh -c '/usr/bin/nmcli networking connectivity | /usr/bin/grep -qFx full'
        ExecStart=/usr/local/bin/ddns-updater --ipv6=public
        | END
    }

    file { '/etc/dhcp/dhclient-exit-hooks.d/ddns-updater':
      source => "puppet:///modules/system/network/dhcp-hook"
    }

    ensure_resource(
      package,
      'python3-boto3',
      { ensure => present })
  }
}
