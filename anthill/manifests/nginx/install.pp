
class anthill::nginx::install inherits anthill::nginx {

  if ($anthill::manage_nginx)
  {
    user { $user:
      ensure           => 'present',
      gid              => $anthill::applications_group,
      shell            => '/bin/bash',
      password         => generate('/bin/sh', '-c', "mkpasswd -m sha-512 ${password} | tr -d '\n'")
    }

    class { '::nginx':
      service_ensure => 'running',
      daemon_user => $user,
      daemon_group => $anthill::applications_group
    }
  }

}