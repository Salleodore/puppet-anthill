
class anthill::puppetdb {

  # Configure puppetdb and its underlying database
  class { puppetdb:
    listen_address => "127.0.0.1"
  }

  Package['apt-transport-https'] -> Class[puppetdb]

  # Configure the Puppet master to use puppetdb
  class { puppetdb::master::config:
    puppetdb_server => "127.0.0.1"
  }

}