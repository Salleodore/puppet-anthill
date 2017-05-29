
class anthill::rabbitmq::install inherits anthill::rabbitmq {

  if ($anthill::manage_rabbitmq)
  {
    apt::key { 'rabbitmq-pgp-key':
      id      => '0A9AF2115F4687BD29803A206B73A36E6026DFCA',
      server  => 'hkps.pool.sks-keyservers.net',
      notify => Exec["apt_update"]
    }

    class { '::rabbitmq':
      port              => $port,
      node_ip_address   => '127.0.0.1',
      management_port   => $admin_port,
      management_ssl    => false,
      admin_enable      => $admin_management,
      delete_guest_user => true
    }

    rabbitmq_vhost { $environment:
        ensure => present,
    }

    rabbitmq_user { 'admin':
        admin    => true,
        password => $admin_password,
        tags     => ['monitoring'],
    }

    rabbitmq_user { $username:
        admin    => false,
        password => $password,
        tags     => ['monitoring'],
    }

    rabbitmq_user_permissions { "admin@${environment}":
        configure_permission => '.*',
        read_permission      => '.*',
        write_permission     => '.*',
    }

    rabbitmq_user_permissions { "${username}@${environment}":
        configure_permission => '.*',
        read_permission      => '.*',
        write_permission     => '.*',
    }

    if ($admin_management) and ($anthill::manage_nginx) {

      include '::nginx'

      $external_domain_name = $anthill::external_domain_name

      nginx::resource::vhost { "${environment}_rabbitmq":
        ensure               => present,
        server_name          => [
          "rabbitmq-${environment}.${external_domain_name}"
        ],
        listen_port          => $anthill::nginx::listen_port,

        ssl                  => $anthill::nginx::ssl,
        ssl_port             => $anthill::nginx::ssl_port,
        ssl_cert             => $anthill::nginx::ssl_cert,
        ssl_key              => $anthill::nginx::ssl_key,

        use_default_location => false,
        index_files          => []
      }

      nginx::resource::location { "${environment}_rabbitmq/":
        ensure        => present,
        location      => "/",
        vhost         => "${environment}_rabbitmq",
        rewrite_rules => [],
        proxy         => "http://127.0.0.1:${admin_port}",
        proxy_buffering => 'off',

        ssl => $anthill::nginx::ssl
      }

    }
    else
    {
      nginx::resource::vhost { "${environment}_rabbitmq":
        ensure => 'abscent'
      }

      nginx::resource::location { "${environment}_rabbitmq/":
        ensure => 'abscent'
      }
    }

  }

}