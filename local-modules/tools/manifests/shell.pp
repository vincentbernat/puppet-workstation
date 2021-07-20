class tools::shell {
  package { ["zsh", "zsh-static"]:
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
  ->
  file { "${::home}/.zshenv":
    owner  => "${::user}",
    group  => "${::group}",
    ensure => link,
    target => "${::home}/.zsh/zshenv"
  }

  package { ["python3-pygments",
             "qualc"]:
               ensure => installed
  }

}
