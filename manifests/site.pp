File {
  owner   => 'root',
  group   => 'root'
}

node default {
  # external modules
  class { "apt":
    purge_sources_list   => true,
    purge_sources_list_d => true,
    purge_preferences_d  => true
  }
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
