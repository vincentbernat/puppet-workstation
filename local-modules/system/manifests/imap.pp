class system::imap {

  package { "isync": ensure => present }
  package { "dovecot-imapd": ensure => present } ->
  package { "dovecot-lucene": ensure => present }

  # Will be started on demand
  service { "dovecot":
    ensure => stopped,
    enable => false,
    require => Package["dovecot-imapd"]
  }

  # Override the default, we want something quite simple
  file { "/etc/dovecot/dovecot.conf":
    source => "puppet:///modules/system/imap/dovecot.conf"
  }

  file { "/etc/apparmor.d/tunables/dovecot":
    source => "puppet:///modules/system/imap/apparmor.conf"
  }

}
