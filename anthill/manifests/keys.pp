
class anthill::keys (
  # file contents for a public key
  $authentication_public_key = undef,
  # file contents and a passphrase for a private key
  $authentication_private_key = undef,
  $authentication_private_key_passphrase = undef,

  # a private key for downloading repositories via SSH
  $ssh_private_key = undef,

  # if https enabled, content files for a ssl-bundle and .key are required
  $enable_https = $anthill::enable_https,
  $https_keys_bundle_contents = undef,
  $https_keys_private_key_contents = undef,

  $applications_user = $anthill::applications_user,
  $applications_group = $anthill::applications_group,

  $application_keys_location = "${anthill::keys_location}/.anthill-keys",
  $application_keys_public_name = 'anthill.pub',
  $application_keys_private_name = 'anthill.pem',

  $https_keys_location = "${anthill::keys_location}/.https",
  $https_keys_bundle_name = "https-${environment}.ssl-bundle",
  $https_keys_private_key_name = "https-${environment}.key"
) {

  file { $application_keys_location:
    ensure => 'directory',
    owner  => $applications_user,
    group  => $applications_group,
    mode   => '0400'
  }

  file { "${application_keys_location}/${environment}":
    ensure => 'directory',
    owner  => $applications_user,
    group  => $applications_group,
    mode   => '0400',
    require => File[$application_keys_location]
  }

  if ($authentication_public_key) {
    file { "${application_keys_location}/${environment}/${application_keys_public_name}":
      ensure  => 'present',
      owner   => $applications_user,
      group   => $applications_group,
      mode    => '0400',
      source  => $authentication_public_key,
      require => File["${application_keys_location}/${environment}"]
    }
  }

  if ($ssh_private_key) {
    file { "/home/${applications_user}/.ssh":
      ensure  => 'directory',
      owner   => $applications_user,
      group   => $applications_group,
      mode    => '0400'
    } -> file { "/home/${applications_user}/.ssh/id_rsa":
      ensure  => 'present',
      owner   => $applications_user,
      group   => $applications_group,
      mode    => '0400',
      source  => $ssh_private_key
    }
  }

  if ($authentication_private_key) {
    file { "${application_keys_location}/${environment}/${application_keys_private_name}":
      ensure => 'present',
      owner => $applications_user,
      group => $applications_group,
      mode   => '0400',
      source => $authentication_private_key,
      require => File["${application_keys_location}/${environment}"]
    }
  }

  if ($enable_https) {
    file { $https_keys_location:
      ensure => 'directory',
      owner  => $applications_user,
      group  => $applications_group,
      mode   => '0400'
    }

    file { "${https_keys_location}/${https_keys_bundle_name}":
      ensure  => 'present',
      owner   => $applications_user,
      group   => $applications_group,
      mode    => '0400',
      source => $https_keys_bundle_contents,
      require => File[$https_keys_location]
    }

    file { "${https_keys_location}/${https_keys_private_key_name}":
      ensure  => 'present',
      owner   => $applications_user,
      group   => $applications_group,
      mode    => '0400',
      source => $https_keys_private_key_contents,
      require => File[$https_keys_location]
    }
  }
}