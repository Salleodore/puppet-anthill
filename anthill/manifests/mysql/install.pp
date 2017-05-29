
class anthill::mysql::install inherits anthill::mysql {

  if ($anthill::manage_mysql) and ($anthill::manage_mysql_server) {
    include '::apt'

    apt::source { 'mysql-5.7':
      location => 'http://repo.mysql.com/apt/debian/',
      repos    => 'mysql-5.7',
      include  => {
        'src' => false,
        'deb' => true,
      },
      key      => {
        'id'     => 'A4A9406876FCBD3C456770C88C718D3B5072E1F5',
        'server' => 'pgp.mit.edu',
      },
      notify => Exec["apt_update"]
    }

    package { 'mysql-server':
      ensure => 'latest',
      require => Apt::Source['mysql-5.7']
    }

  }

}