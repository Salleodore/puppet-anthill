
class anthill::rabbitmq::install inherits anthill::rabbitmq {

  if ($anthill::manage_rabbitmq)
  {
    if ($::operatingsystem == 'Debian' and $::operatingsystemmajrelease == '8')
    {
      apt::source { 'debian_8_erlang':
        location => 'https://packages.erlang-solutions.com/debian',
        release  => 'jessie',
        repos    => 'contrib'
      }

      apt::key { 'erlang_solutions':
        id => "434975BD900CCBE4F7EE1B1ED208507CA14F4FCA",
        source => "https://packages.erlang-solutions.com/debian/erlang_solutions.asc",
        notify => Class['apt::update'],
        require => Apt::Source['debian_8_erlang']
      }

      Apt::Key['erlang_solutions'] -> Class['rabbitmq']
    }

    class { ::rabbitmq:
      port              => $port,
      node_ip_address   => $anthill::dns::local_ip_address,
      management_ip_address => $anthill::dns::local_ip_address,
      management_port   => $admin_port,
      management_ssl    => false,
      admin_enable      => $admin_management,
      delete_guest_user => true,
      repos_ensure => true,
      environment_variables => {
        'LC_ALL' => 'en_US.UTF-8',
      }
    }

    @@anthill::dns::entry { "rabbitmq":
      internal_hostname => "rabbitmq-${environment}.${anthill::internal_domain_name}",
      tag => "internal"
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

      nginx::resource::server { "${environment}_rabbitmq":
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
        ensure               => present,
        location             => "/",
        server               => "${environment}_rabbitmq",
        rewrite_rules        => [],
        proxy                => "http://127.0.0.1:${admin_port}",
        proxy_buffering      => 'off',

        ssl => $anthill::nginx::ssl
      }

    }
    else
    {
      nginx::resource::server { "${environment}_rabbitmq":
        ensure => 'abscent'
      }

      nginx::resource::location { "${environment}_rabbitmq/":
        ensure => 'abscent'
      }
    }

  }

}