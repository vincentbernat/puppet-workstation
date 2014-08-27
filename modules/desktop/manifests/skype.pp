class skype {

  exec { 'retrieve_skype':
    command => "/usr/bin/wget -q http://www.skype.com/go/getskype-linux-deb-32 -O /opt/skype.deb",
    creates => "/opt/skype.deb",
    notify => Package["skype"]
  }

  # This won't work as the dependencies are missing. The use has to do "apt-get install -f".
  package { "skype":
    provider => dpkg,
    ensure   => installed,
    source   => "/opt/skype.deb",
    require  => Exec['retrieve_skype']
  }

}
