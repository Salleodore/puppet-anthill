class anthill::vpn (
  $mode                  = 'client',

  # both clients and server has to have the same tag
  $vpn_tag,

  # client options
  $client_index          = undef,
  $client_server_fqdn    = "vpn-${environment}.${anthill::external_domain_name}",
  $client_dev            = 'tun',

  # server options
  $server_country        = undef,
  $server_province       = undef,
  $server_city           = undef,
  $server_organization   = undef,
  $server_email          = undef,
  $server_ssl_key_size   = 4096,

  # other options
  $network_ip            = '10.8.0.0',
  $network_subnet        = '255.255.255.0',
  $network_offset        = '8',
  $proto                 = 'udp',
  $port                  = '1194',

  $ip = $mode ? {
    'client' => ip_address(ip_increment("${network_ip}/${network_offset}", 2 + $client_index * 3)),
    'server' => ip_address(ip_increment("${network_ip}/${network_offset}")),
    default => fail("Unknown mode: ${mode}")
  }
) {
  $openvpn_service_name = 'anthill'

  if ($mode == 'client') {
    if ($client_index == undef or $client_server_fqdn == undef) {
      fail("Missing client_* configuration")
    }

    $client_name = $::fqdn

    # export Anthill::Vpn::Client to the vpn server
    @@anthill::vpn::client { $client_name:
      dev => $client_dev,
      client_index => $client_index,
      proto => $proto,
      server => $openvpn_service_name,
      client_address_a => $ip,
      client_address_b => ip_address(ip_increment("${ip}/${network_offset}")),
      tag => [ $vpn_tag ]
    }

    # if the remote server exported VPN client keys for us, realize them here
    File <<| tag == "openvpn_${openvpn_service_name}_${client_name}" |>>

    # If we have "ca.crt" file in place (see lib/facter/openvpn_client_keys.rb)
    $can_start_openvpn = $facts["openvpn_${openvpn_service_name}_client_keys"]

    class { 'openvpn':
      manage_service => $can_start_openvpn
    }

    openvpn::server { $openvpn_service_name:
      remote          => [ "${client_server_fqdn} ${port}" ],
      proto           => $proto,
      nobind          => true,
      persist_key     => true,
      persist_tun     => true,
      tls_client      => true,
      tls_version_min => '1.2',
      local           => ''
    }

  } elsif ($mode == 'server') {

    include ::openvpn

    if ($server_country == undef or $server_province == undef or $server_city == undef or
        $server_organization == undef or $server_email == undef) {
      fail("Missing server_* configuration")
    }

    $my_fqdn = $::fqdn

    openvpn::server { $openvpn_service_name:
      country      => $server_country,
      province     => $server_province,
      city         => $server_city,
      organization => $server_organization,
      email        => $server_email,
      proto        => $proto,
      server       => "${network_ip} ${network_subnet}",
      ssl_key_size => $server_ssl_key_size,
      port         => $port,
      persist_key  => true,
      persist_tun  => true,
      tls_server   => true,
      tls_version_min => '1.2',
      local        => ''
    }

    # realize clients that are about to connect ot us (see line 43)
    Anthill::Vpn::Client <<| tag == $vpn_tag |>>

  } else {
    fail("Unknown mode: ${mode}")
  }
}