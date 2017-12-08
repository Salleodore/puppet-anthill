
class anthill::redis::install inherits anthill::redis {

  if ($anthill::manage_redis)
  {
    class { '::redis':
      service_ensure => 'running',
      port => $port,
      databases => $databases_count,
      bind => '127.0.0.1',
      package_ensure => 'latest',
      manage_repo => true
    }
  }
}