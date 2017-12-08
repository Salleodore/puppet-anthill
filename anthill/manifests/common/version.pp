
define anthill::common::version (
  $source_commit,
  $ensure = present,
  $version = $title,

  $library_directory = $anthill::common::source_directory,
  $library_name = $anthill::common::library_name,
  $source_directory = $anthill::common::source_directory
) {
  $version_directory = "${source_directory}/${version}"

  if ($source_directory) {
    anthill::checkout_version { "${environment}_${library_name}":
      ensure => $ensure,
      version_directory => $version_directory,
      source_directory => "${source_directory}/.git",
      source_commit => $source_commit,
      directory_name => $library_name
    }
  }

}