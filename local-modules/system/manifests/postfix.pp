class system::postfix($relays) {

  package { postfix: ensure => installed }

  file { "/etc/postfix/main.cf":
    content => template("system/postfix/main.cf.erb"),
    notify  => Service["postfix"]
  }
  file { "/etc/postfix/master.cf":
    source => "/usr/share/postfix/master.cf.dist",
    notify  => Service["postfix"]
  }
  file { "/etc/postfix/sasl_passwd":
    content   => template("system/postfix/sasl_passwd.erb"),
    mode      => "0640",
    show_diff => false,
    notify    => Exec["postmap"]
  }
  file { "/etc/postfix/relayhost_maps":
    content => template("system/postfix/relayhost_maps.erb"),
    notify  => Exec["postmap"]
  }
  file { "/etc/postfix/tls_policy":
    content => template("system/postfix/tls_policy.erb"),
    notify  => Exec["postmap"]
  }
  file { "/etc/aliases":
    content => template("system/postfix/aliases.erb"),
    notify  => Exec["postalias"]
  }

  service { postfix:
    ensure  => running,
    require => Package["postfix"]
  }


  file { "/etc/mailname":
    content => template("system/postfix/mailname.erb"),
    notify  => Service["postfix"]
  }

  exec { "postalias":
    command     => "/usr/sbin/postalias /etc/aliases",
    refreshonly => true
  }
  exec { "postmap":
    command     => "/usr/sbin/postmap /etc/postfix/sasl_passwd /etc/postfix/relayhost_maps /etc/postfix/tls_policy",
    refreshonly => true
  }

}
