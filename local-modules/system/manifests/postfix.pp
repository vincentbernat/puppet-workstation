class system::postfix($relay, $relayauth, $origin) {

  package { postfix: ensure => installed }

  file { "/etc/postfix/main.cf":
    content => template("system/postfix/main.cf.erb"),
    notify => Service["postfix"]
  }
  file { "/etc/postfix/sasl_passwd":
    content => "# Managed by Puppet.\n[${relay}]:587 ${relayauth}\n",
    mode    => "0640",
    notify  => Exec["postmap"]
  }

  file { "/etc/aliases":
    content => template("system/postfix/aliases.erb"),
    notify => Exec["postalias"]
  }

  service { postfix:
    ensure => running,
    require => Package["postfix"]
  }


  file { "/etc/mailname":
    content => template("system/postfix/mailname.erb"),
    notify => Service["postfix"]
  }

  exec { "postalias":
    command     => "/usr/sbin/postalias /etc/aliases",
    refreshonly => true
  }
  exec { "postmap":
    command     => "/usr/sbin/postmap /etc/postfix/sasl_passwd",
    refreshonly => true
  }

}
