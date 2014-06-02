class skype {

  package { "skype":
    provider => dpkg,
    ensure   => installed,
    source   => "http://www.skype.com/go/getskype-linux-deb-32"
  }
  ->
  package { "gtk2-engines-pixbuf:i386": ensure => installed }

}
