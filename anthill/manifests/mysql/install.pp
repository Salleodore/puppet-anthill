
class anthill::mysql::install inherits anthill::mysql {

  if ($anthill::manage_mysql) {
    include '::apt'

    apt::source { 'mysql-5.7':
      location => 'http://repo.mysql.com/apt/debian/',
      repos    => 'mysql-5.7',
      include  => {
        'src' => false,
        'deb' => true,
      },
      key      => {
        'id'     => 'A4A9406876FCBD3C456770C88C718D3B5072E1F5',
        'server' => 'pgp.mit.edu',
      }
    }

    @@anthill::dns::entry { "mysql":
      internal_hostname => "mysql-${environment}.${anthill::internal_domain_name}",
      tag => "internal"
    }

    class { '::mysql::server':
      package_name            => 'mysql-server',
      package_ensure          => '5.7.17-1debian8',
      root_password           => $mysql_root_password,
      remove_default_accounts => true,
      override_options => {
        "event_scheduler" => "ON"
      }
    }

    Apt::Source['mysql-5.7'] ~>
    Class['apt::update'] ->
    Class['::mysql::server']
  }

}