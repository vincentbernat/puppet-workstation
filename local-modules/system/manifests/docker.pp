class system::docker {
  package { ["docker.io",
             "docker-compose",
             "podman"]: ensure => installed }
  ->
  file { "/etc/docker/daemon.json":
    content => @(END)
      {"default-address-pools": [{"base":"241.107.0.0/16","size":24}],
       "bip": "241.107.255.1/24"}
      | END
  }
  ~>
  service { "docker":
    enable => false
  }
}
