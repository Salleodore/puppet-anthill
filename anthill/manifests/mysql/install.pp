
class anthill::mysql::install inherits anthill::mysql {

  include ::apt

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

  class { ::mysql::server:
    package_name            => 'mysql-server',
    package_ensure          => $mysql_package,
    root_password           => $root_password,
    remove_default_accounts => true,
    purge_conf_dir          => true,
    includedir              => '/etc/mysql/mysql.conf.d',
    restart                 => true,
    override_options        => {
      "mysqld" => {
        "event_scheduler" => "ON",
        "port"            => $listen_port,
        "bind-address"    => $anthill::internal_fqdn
      }
    }
  }

  Apt::Source['mysql-5.7'] ~>
  Class['apt::update'] ->
  Class['::mysql::server']

}