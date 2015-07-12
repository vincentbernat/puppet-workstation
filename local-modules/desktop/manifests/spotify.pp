class spotify {

  apt::source { 'spotify':
    location    => 'http://repository.spotify.com',
    release     => 'stable',
    repos       => 'non-free',
    key         => 'D2C19886',
    key_server  => 'subkeys.pgp.net',
    include_src => false,
    pin         => 400
  }
  ->
  package { 'spotify-client': ensure => installed }

}
