
define anthill::source (
  $repository_remote_url,
  $repository_local_directory
) {

  include git

  vcsrepo { $repository_local_directory:
    ensure   => mirror,
    provider => git,
    source   => $repository_remote_url,
    user => $anthill::applications_user,
    force => true,
    trust_server_cert => true
  } -> exec { "update_source_${repository_local_directory}":
    command => "/usr/bin/git remote update --prune",
    cwd => $repository_local_directory,
    timeout => 1800,
    user => $anthill::applications_user
  }

}

define anthill::checkout_version (
  $ensure = present,
  $version_directory,
  $source_directory,
  $directory_name,
  $source_commit
) {

  if ($ensure == present) {
    include git

    validate_re($source_commit, "^[0-9a-f]{40}$", "source_commit should be a valid Git commit 40-characters hash.")

    $test_condition_a = "! -f \"${version_directory}/.revision\""
    $test_condition_b = "\"${source_commit}\" != `cat \"${version_directory}/.revision\"`"

    $test_condition = "/usr/bin/test ${test_condition_a} || /usr/bin/test ${test_condition_b}"

    # create a directory for specific version
    file { "${version_directory}":
      ensure => 'directory',
      owner  => $anthill::applications_user,
      group  => $anthill::applications_group,
      mode   => '0760'
      # check out the source in version-specific directory, but only of the commit has changed
    } -> exec { "checkout_version_${version_directory}":
      command   => "/usr/bin/git --work-tree=\"${version_directory}/\" checkout ${source_commit} -- .",
      user      => $anthill::applications_user,
      cwd       => $source_directory,
      onlyif    => $test_condition,
      logoutput => 'on_failure',
      require   => Anthill::Source["${environment}_${directory_name}"],
    } -> file { "${version_directory}/.revision":
      ensure  => file,
      content => $source_commit
    }
  }
  else
  {
    file { "${version_directory}":
      ensure => 'absent',
      force => true
    }
  }
}