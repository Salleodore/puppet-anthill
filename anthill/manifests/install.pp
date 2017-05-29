
class anthill::install inherits anthill {

  group { $applications_group:
    ensure           => 'present'
  }

  user { $applications_user:
    ensure           => 'present',
    gid              => $applications_group,
    home             => "/home/${applications_user}",
    shell            => '/bin/bash',
    password         => $applications_user_password
  }

  file { "/home/${applications_user}":
    ensure => 'directory',
    owner  => $applications_user,
    mode   => '0750',
    require => User[$applications_user]
  }

  file { $applications_location:
    ensure => 'directory',
    owner  => 'root',
    group => $applications_group,
    mode   => '0760',
    require => Group[$applications_group]
  }

  file { "${applications_location}/${environment}":
    ensure => 'directory',
    owner  => $applications_user,
    group => $applications_group,
    mode   => '0760',
    require => File[$applications_location]
  }

  package { 'libmysqlclient-dev': ensure => 'present' }
  package { 'build-essential': ensure => 'present' }
  package { 'libcurl4-openssl-dev': ensure => 'present' }
  package { 'libssl-dev': ensure => 'present' }
  package { 'libffi-dev': ensure => 'present' }
  package { 'ntp': ensure => 'present' }

}