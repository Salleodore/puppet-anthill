class anthill::monitoring::grafana::location inherits anthill::monitoring::grafana {

  if ($export_location)
  {
    @@anthill::location { $export_location_name:
        host => $anthill::internal_fqdn,
        port => $listen_port,
        username => $admin_username,
        password => $admin_password
    }
  }

}