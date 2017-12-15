
class anthill::python inherits anthill {

  class { '::python' :
    version    => "system",
    pip        => 'present',
    dev        => 'present',
    virtualenv => 'present'
  }

  $venv = "${anthill::virtualenv_location}/${environment}"

  file { "${anthill::virtualenv_location}":
    ensure => 'directory',
    owner  => 'root',
    group => $applications_group,
    mode   => '0760'
  }

  python::virtualenv { $venv:
    ensure       => present,
    version      => 'system',
    owner        => $anthill::applications_user,
    group        => $anthill::applications_group,
    cwd          => "${anthill::applications_location}/${environment}",
    require => File["${anthill::virtualenv_location}"]
  }

  python::pip { 'termcolor': virtualenv => $venv, require => Python::Virtualenv[$venv] }
  python::pip { 'ipaddr': virtualenv => $venv, require => Python::Virtualenv[$venv] }
  python::pip { 'ujson': virtualenv => $venv, require => Python::Virtualenv[$venv] }
  python::pip { 'pyzmq': virtualenv => $venv, require => Python::Virtualenv[$venv] }
  python::pip { 'redis': virtualenv => $venv, require => Python::Virtualenv[$venv] }
  python::pip { 'tornado': virtualenv => $venv, require => Python::Virtualenv[$venv] }
  python::pip { 'tornado-redis': virtualenv => $venv,
    url => "git+https://github.com/anthill-utils/tornado-redis.git",
    require => Python::Virtualenv[$venv] }
  python::pip { 'pycrypto': virtualenv => $venv, require => Python::Virtualenv[$venv] }
  python::pip { 'mysql-python': virtualenv => $venv, require => Python::Virtualenv[$venv] }
  python::pip { 'pymysql':
    virtualenv => $venv,
    url => "git+https://github.com/anthill-utils/PyMySQL.git",
    returns => [0, 1],
    require => [Python::Virtualenv[$venv], Package["libmysqlclient-dev"]]
  }
  python::pip { 'tormysql': virtualenv => $venv,
    require => [Python::Pip['pymysql'], Python::Virtualenv[$venv]]}
  python::pip { 'sphinx': virtualenv => $venv, require => Python::Virtualenv[$venv] }
  python::pip { 'pyjwt': virtualenv => $venv,
    url => "git+https://github.com/anthill-utils/pyjwt.git",
    require => Python::Virtualenv[$venv]}
  python::pip { 'pika': virtualenv => $venv,
    url => "git+https://github.com/anthill-utils/pika.git",
    require => Python::Virtualenv[$venv] }
  python::pip { 'pyOpenSSL': virtualenv => $venv, require => Python::Virtualenv[$venv] }
  python::pip { 'cffi': virtualenv => $venv, require => Python::Virtualenv[$venv] }
  python::pip { 'cryptography': virtualenv => $venv, require => Python::Virtualenv[$venv] }
  python::pip { 'futures': virtualenv => $venv, require => Python::Virtualenv[$venv] }
  python::pip { 'ipgetter': virtualenv => $venv, require => Python::Virtualenv[$venv] }
  python::pip { 'expiringdict': virtualenv => $venv, require => Python::Virtualenv[$venv] }
  python::pip { 'python-geoip': virtualenv => $venv, require => Python::Virtualenv[$venv] }
  python::pip { 'python-geoip-geolite2-yplan': virtualenv => $venv, require => Python::Virtualenv[$venv] }
  python::pip { 'psutil': virtualenv => $venv, require => Python::Virtualenv[$venv] }
  python::pip { 'lazy': virtualenv => $venv, require => Python::Virtualenv[$venv] }
  python::pip { 'GitPython': virtualenv => $venv, require => Python::Virtualenv[$venv]}
  python::pip { 'sprockets-influxdb': virtualenv => $venv, require => Python::Virtualenv[$venv]}

}