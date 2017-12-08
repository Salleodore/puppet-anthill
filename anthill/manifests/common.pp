
class anthill::common (

  $library_name = $anthill::common::params::library_name,
  $repository_remote_url = $anthill::common::params::repository_remote_url,
  $source_directory = $anthill::common::params::source_directory,

) inherits anthill::common::params {

  if ($source_directory) {
    file { $source_directory:
      ensure => 'directory',
      owner  => $anthill::applications_user,
      group  => $anthill::applications_group,
      mode   => '0760'
    }

    if ($repository_remote_url)
    {
      anthill::source { "${environment}_${library_name}":
        repository_remote_url => $repository_remote_url,
        repository_local_directory => "${source_directory}/.git"
      }

      File[$source_directory] -> Anthill::Source["${environment}_${library_name}"]
    }
  }
}