
define anthill::source (
  $api_version,
  $repository_location = "https://github.com/anthill-platform/anthill.git",
  $repository_branch = undef,
  $repository_hash = undef
) {

  vcsrepo { "${anthill::applications_location}/${environment}/${api_version}":
    ensure   => present,
    provider => git,
    source   => $repository_location,
    revision => $repository_hash,
    branch => $repository_branch,
    user => $anthill::applications_user
  }

}