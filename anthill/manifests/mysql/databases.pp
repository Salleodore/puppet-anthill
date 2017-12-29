class anthill::mysql::databases inherits anthill::mysql {

  Mysql_database <<| tag == $export_location_name |>>

  Class[Mysql::Server] -> Mysql_database <<| tag == $export_location_name |>>

}