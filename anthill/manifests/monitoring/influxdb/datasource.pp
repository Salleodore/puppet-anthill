
class anthill::monitoring::influxdb::datasource inherits anthill::monitoring::influxdb {

  if ($export_grafana_datasource) {
    anthill::ensure_location("grafana location", $grafana_location)

    $grafana_host = getparam(Anthill::Location[$grafana_location], "host")
    $grafana_port = getparam(Anthill::Location[$grafana_location], "port")
    $grafana_admin_username = getparam(Anthill::Location[$grafana_location], "username")
    $grafana_admin_password = getparam(Anthill::Location[$grafana_location], "password")

    @@grafana_datasource { 'influxdb':
      grafana_url      => "http://${grafana_host}:${grafana_port}",
      grafana_user     => $grafana_admin_username,
      grafana_password => $grafana_admin_password,
      type             => 'influxdb',
      url              => "http://${anthill::internal_fqdn}:${http_listen_port}",
      user             => $admin_username,
      password         => $admin_password,
      database         => $database_name,
      access_mode      => 'proxy',
      is_default       => true
    }
  }

}