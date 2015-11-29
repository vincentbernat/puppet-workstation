class skype {

  # Use Ubuntu repository for that
  apt::source { 'ubuntu-partners':
    location          => 'http://archive.canonical.com/',
    release           => 'trusty',
    repos             => 'partner',
    required_packages => 'ubuntu-archive-keyring',
    include_src       => false,
    key               => '40976EAF437D05B5',
    pin               => -100
  }
  apt::pin { 'skype':
    priority   => 200,
    component  => partner,
    originator => Canonical,
    packages   => skype-bin
  }

  package { "skype-bin:i386": ensure => installed }

}
