#
# See https://ydns.eu/
#
class system::network::ydns($username, $password, $domain="ydns.eu") {

  file { "/usr/local/bin/ydns-updater":
    content => template("system/network/ydns-updater.erb"),
    owner => root,
    mode => "0700"
  }
  ->
  cron { "ydns-updater":
    command => "/usr/local/bin/ydns-updater ${hostname}.${domain}",
    minute => '*/10'
  }

}
