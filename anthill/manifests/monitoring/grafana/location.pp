class anthill::monitoring::grafana::location inherits anthill::monitoring::grafana {

  if ($export_location)
  {
    @@anthill::location { $export_location_name:
      host => $anthill::internal_fqdn,
      port => $listen_port,
      other => {
        "admin_username" => $admin_username,
        "admin_password" => $admin_password
      }
    }
  }

}