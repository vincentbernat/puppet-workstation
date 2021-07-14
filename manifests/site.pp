File {
  owner   => 'root',
  group   => 'root'
}

node default {
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
