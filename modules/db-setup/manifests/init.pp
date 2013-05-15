# -L for don't prompt on error
# sqlplus -L system/manager@//localhost:1521/XE @/Users/cthompson/vagrant/vagrant-ubuntu-oracle-xe/modules/db-setup/files/create_APP_DBO

class db-setup {

  file { '/tmp/create-users-and-tbsps.sql':
    source => "puppet:///modules/db-setup/local_oracle_tyler.sql";
  }
  ->
  exec {'create-users-and-tbsps':
    command => "sqlplus -L system/manager@localhost:1521/XE @/tmp/create-users-and-tbsps",
    path    => '/u01/app/oracle/product/11.2.0/xe/bin/',
    timeout => 10,
    require => Service['oracle-xe'],
  }

}
