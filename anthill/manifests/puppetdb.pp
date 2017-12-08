
class anthill::puppetdb {

  # Configure puppetdb and its underlying database
  package { 'apt-transport-https':
    provider => apt
  } -> class { puppetdb:
    listen_address => $::fqdn
  }

  # Configure the Puppet master to use puppetdb
  class { puppetdb::master::config:
    puppetdb_server => $::fqdn
  }

}