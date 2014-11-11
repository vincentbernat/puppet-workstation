class postfix($relay = undef, $cert = undef, $key = undef, $origin = undef) {

  package { postfix: ensure => installed }

  file { "/etc/postfix/main.cf":
    content => template("system/postfix/main.cf.erb"),
    notify => Service["postfix"]
  }

  file { "/etc/aliases":
    content => template("system/postfix/aliases.erb"),
    notify => Exec["postalias"]
  }

  service { postfix:
    ensure => running,
    require => Package["postfix"]
  }

  if ($key != undef) {
    file { "/etc/ssl/private/postfix.key":
      mode => 0600,
      content => "${key}",
      notify => Service["postfix"]
    }
  }
  else {
    warning('no key present for postfix')
  }
  if ($cert != undef) {
    file { "/etc/ssl/postfix.pem":
      content => "${cert}",
      notify => Service["postfix"]
    }
  }
  else {
    warning('no certificate present for postfix')
  }

  if ($origin != undef) {
    file { "/etc/mailname":
      content => template("system/postfix/mailname.erb"),
      notify => Service["postfix"]
    }
  }

  exec { "postalias":
    command => "/usr/sbin/postalias /etc/aliases"
  }

}
