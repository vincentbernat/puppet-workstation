File {
  owner   => 'root',
  group   => 'root'
}

node default {
  # external modules
  class { "apt":
    purge => {
      "sources.list"   => true,
      "sources.list.d" => true,
      "preferences"    => true,
      "preferences.d"  => true
    }
  }
  class { "udev":
    udevadm_path => '/bin'
  }

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
