class davmail {

  exec { "retrieve_davmail":
    command => "/usr/bin/wget -q http://downloads.sourceforge.net/project/davmail/davmail/4.5.0/davmail-4.5.0-2292.zip -O /opt/davmail.zip",
    creates => "/opt/davmail.zip",
    notify => Exec["unpack_davmail"]
  }

  file { "/opt/davmail":
    ensure => directory
  }
  ->
  exec { "unpack_davmail":
    refreshonly => true,
    command => "/usr/bin/unzip /opt/davmail.zip",
    cwd => "/opt/davmail"
  }

}
