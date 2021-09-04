class system::docker {
  package { ["docker.io",
             "docker-compose",
             "podman"]: ensure => installed }
  ->
  User <| title == "${::user}" |> {
    groups +> "docker"
  }
  ->
  file { "/etc/docker/daemon.json":
    content => @(END)
      {"default-address-pools": [{"base":"100.107.0.0/16","size":24}]}
      | END
  }
  ~>
  service { "docker": }
}
