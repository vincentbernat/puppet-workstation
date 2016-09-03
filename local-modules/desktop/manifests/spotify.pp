class desktop::spotify {

  apt::source { 'spotify':
    location    => 'http://repository.spotify.com',
    release     => 'testing',
    repos       => 'non-free',
    key         => 'BBEBDCB318AD50EC6865090613B00F1FD2C19886',
    key_server  => 'subkeys.pgp.net',
    include_src => false,
    pin         => 400
  }
  ->
  package { 'xdotool': ensure => installed } ->
  package { 'spotify-client': ensure => installed }

}
