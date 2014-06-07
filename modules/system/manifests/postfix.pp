class postfix($relay, $cert, $key) {

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

  file { "/etc/ssl/private/postfix.key":
    mode => 0600,
    content => "${key}",
    notify => Service["postfix"]
  }
  file { "/etc/ssl/postfix.pem":
    content => "${cert}",
    notify => Service["postfix"]
  }

  exec { "postalias":
    command => "/usr/sbin/postalias /etc/aliases"
  }

  file { "/etc/postfix/transport":
    source => "puppet:///modules/system/postfix/transport",
    notify => Service["postfix"]
  }

}
