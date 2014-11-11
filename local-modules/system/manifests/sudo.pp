class sudo {

  package { "sudo": ensure => installed } ->
  User <| title == "${::user}" |> { groups +> "sudo" }

}
