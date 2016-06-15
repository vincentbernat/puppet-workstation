class tools::shell {
  package { "zsh":
    ensure => installed
  }
  ->
  User <| title == "${::user}" |> { shell => "/bin/zsh" }
  ->
  file { "${::home}/.zshrc":
    owner => "${::user}",
    group => "${::group}",
    content => template("tools/shell/zshrc.erb")
  }

  package { "python-pygments": ensure => installed }

}
