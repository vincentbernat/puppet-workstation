class tools::shell {
  package { "zsh":
    ensure => installed
  }
  ->
  User <| title == "${::user}" |> { shell => "/bin/zsh" }
  ->
  file { "${::home}/.zshrc":
    owner  => "${::user}",
    group  => "${::group}",
    ensure => link,
    target => "${::home}/.zsh/zshrc"
  }

  package { "python-pygments": ensure => installed }

}
