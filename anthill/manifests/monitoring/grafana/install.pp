
class anthill::monitoring::grafana::install inherits anthill::monitoring::grafana {

  if ($redis_backend_location)
  {
    anthill::ensure_location("redis backend", $redis_backend_location)

    $redis_backend_host = getparam(Anthill::Location[$redis_backend_location], "host")
    $redis_backend_port = getparam(Anthill::Location[$redis_backend_location], "port")

    if ($redis_backend_host and $redis_backend_port) {
      $session = {
        provider        => "redis",
        provider_config => "addr=${redis_backend_host}:${redis_backend_port},pool_size=100,prefix=grafana"
      }
    } else {
      $session = {}
    }

  } else {
    $session = {}
  }

  anthill::ensure_location("mysql backend", $mysql_backend_location)

  $mysql_backend_host = getparam(Anthill::Location[$mysql_backend_location], "host")
  $mysql_backend_port = getparam(Anthill::Location[$mysql_backend_location], "port")

  class { ::grafana:
    cfg => {
      app_mode => $anthill::debug ? {true => 'development', false => 'production'},
      server   => {
        http_addr     => $listen_host,
        http_port     => $listen_port,
        root_url => "${anthill::protocol}://grafana-${environment}.${anthill::external_domain_name}"
      },
      database => {
        url => "mysql://${mysql_backend_username}:${mysql_backend_password}@${mysql_backend_host}:${mysql_backend_port}/${mysql_backend_db}"
      },
      users    => {
        allow_sign_up => false,
      },
      security => {
        admin_user => $admin_username,
        admin_password => $admin_password
      },
      session => $session
    }
  } -> Grafana_datasource <<| |>>

  if ($manage_mysql_db) {
    if ! defined(Class[Anthill::Mysql]) {
      fail("class { anthill::mysql: } is required to manage database ")
    }

    mysql_database { $mysql_backend_db:
      ensure => $ensure,
      charset => 'utf8'
    }
  }

  if ($manage_mysql_user) {
    if ! defined(Class[Anthill::Mysql]) {
      fail("class { anthill::mysql: } is required to manage user ")
    }

    mysql_user { "${mysql_backend_username}@${mysql_backend_host}":
      ensure                   => 'present',
      password_hash            => mysql_password($mysql_backend_password),
      max_connections_per_hour => '0',
      max_queries_per_hour     => '0',
      max_updates_per_hour     => '0',
      max_user_connections     => '0',
      require => Package['mysql-server']
    }

    mysql_grant { "${mysql_backend_username}@${mysql_backend_host}/*.*":
      ensure     => 'present',
      options    => ['GRANT'],
      privileges => ['ALL'],
      table      => "*.*",
      user       => "${mysql_backend_username}@${mysql_backend_host}",
      require => Package['mysql-server']
    }
  }

}