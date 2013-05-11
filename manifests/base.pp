node oracle {
  include oracle::server
  include oracle::swap
  include oracle::xe
  include db-setup

  user { "vagrant":
    groups => "dba",
    # So that we let Oracle installer create the group
    require => Service["oracle-xe"],
  }
}
