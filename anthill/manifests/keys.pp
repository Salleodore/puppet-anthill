
class anthill::keys (

  $application_keys_passphrase,
  $master_keys_location,
  $private_key_passphrase = undef,

  $enable_https = $anthill::enable_https,

  $applications_keys_location = $anthill::applications_keys_location,
  $applications_user = $anthill::applications_user,
  $applications_group = $anthill::applications_group,

  $applications_keys_public_key = $anthill::applications_keys_public_key,
  $applications_keys_private_key = $anthill::applications_keys_private_key,

  $https_keys_location = $anthill::https_keys_location,
  $https_keys_certificate = $anthill::https_keys_certificate,
  $https_keys_private_key = $anthill::https_keys_private_key
) {

  $app_keys_path = "${anthill::applications_location}/${environment}/${applications_keys_location}"

  file { $app_keys_path:
    ensure => 'directory',
    owner  => $applications_user,
    group  => $applications_group,
    mode   => '0440'
  }

  file { "$app_keys_path/${applications_keys_public_key}":
    ensure => 'present',
    owner => $applications_user,
    group => $applications_group,
    mode   => '0440',
    content => file("${master_keys_location}/${applications_keys_public_key}"),
    require => File[$app_keys_path]
  }

  if ($private_key_passphrase) {
    file { "$app_keys_path/${applications_keys_private_key}":
      ensure => 'present',
      owner => $applications_user,
      group => $applications_group,
      mode   => '0440',
      content => file("${master_keys_location}/${applications_keys_private_key}"),
      require => File[$app_keys_path]
    }
  }

  if ($enable_https) {
    file { $https_keys_location:
      ensure => 'directory',
      owner  => $applications_user,
      group  => $applications_group,
      mode   => '0440'
    }

    file { "${https_keys_location}/${https_keys_certificate}":
      ensure  => 'present',
      owner   => $applications_user,
      group   => $applications_group,
      mode    => '0440',
      content => file("${master_keys_location}/${https_keys_certificate}"),
      require => File[$https_keys_location]
    }

    file { "${https_keys_location}/${https_keys_private_key}":
      ensure  => 'present',
      owner   => $applications_user,
      group   => $applications_group,
      mode    => '0440',
      content => file("${master_keys_location}/${https_keys_private_key}"),
      require => File[$https_keys_location]
    }
  }
}