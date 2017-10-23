
class anthill::mysql::server inherits anthill::mysql {

  if ($anthill::manage_mysql) {

    class { '::mysql::server':
      package_manage          => false,
      root_password           => $mysql_root_password,
      remove_default_accounts => true,
      override_options => {
        "event_scheduler" => "ON"
      }
    }

  }

}