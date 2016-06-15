class system::logging {

  # Logging with systemd journal.

  file { "/var/log/journal":
    ensure => directory,
    group => "systemd-journal"
  }

  exec { "Set ACL on /var/log/journal":
    command => "/usr/bin/setfacl -R -nm g:adm:rx,d:g:adm:rx /var/log/journal",
    unless => "/usr/bin/getfacl /var/log/journal | /bin/grep '^group:adm:r-x' && /usr/bin/getfacl /var/log/journal | /bin/grep '^default:group:adm:r-x'",
    require => Package["acl"]
  }

  package { "acl": ensure => installed }

}
