File {
  owner   => 'root',
  group   => 'root'
}

node default {
  class { "apt":
    purge_sources_list   => true,
    purge_sources_list_d => true,
    purge_preferences_d  => true
  }

  # The current user is virtual to allow modifications from multiple places
  @user { "${::user}":
    groups => [],
    membership => minimum
  }

  include debian
  include system
  include tools
  include desktop
  include dev

}
