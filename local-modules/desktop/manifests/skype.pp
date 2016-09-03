class desktop::skype {

  # Use Ubuntu repository for that
  apt::source { 'ubuntu-partners':
    location          => 'http://archive.canonical.com/',
    release           => 'xenial',
    repos             => 'partner',
    required_packages => 'ubuntu-archive-keyring',
    include_src       => false,
    key               => '630239CC130E1A7FD81A27B140976EAF437D05B5',
    pin               => -100
  }
  ->
  apt::pin { 'skype':
    priority   => 200,
    component  => "partner",
    originator => "Canonical",
    packages   => "skype-bin:i386"
  }
  ->
  package { "skype-bin:i386": ensure => installed }

}
