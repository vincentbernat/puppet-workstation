File {
  owner   => 'root',
  group   => 'root'
}

node default {
  # external modules
  file { '/sbin/udevadm':
    ensure => link,
    target => '../bin/udevadm'
  } ->
  class { "udev": }

  # The current user is virtual to allow modifications from multiple places
  @user { "${::user}":
    groups => [ "adm" ],
    membership => minimum
  }

  include debian
  include system
  include tools
  include desktop
  include dev

}
