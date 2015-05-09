class logging {

  # Logging with systemd journal.

  # No need to log with syslog anymore.
  package { ["rsyslog", "syslog-ng"]:
    ensure => absent
  }

  file { "/var/log/journal":
    ensure => directory,
    group => "systemd-journal"
  }

}
