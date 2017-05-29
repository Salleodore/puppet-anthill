
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

  package { 'libboost-python-dev': ensure => 'present' }
  package { 'libboost-system-dev': ensure => 'present' }
  package { 'libboost-thread-dev': ensure => 'present' }

  python::pip { 'termcolor': virtualenv => $venv }
  python::pip { 'ipaddr': virtualenv => $venv }
  python::pip { 'ujson': virtualenv => $venv }
  python::pip { 'pyzmq': virtualenv => $venv }
  python::pip { 'redis': virtualenv => $venv }
  python::pip { 'tornado': virtualenv => $venv }
  python::pip { 'tornado-redis': virtualenv => $venv, url => "git+https://github.com/anthill-utils/tornado-redis.git" }
  python::pip { 'pycrypto': virtualenv => $venv }
  python::pip { 'mysql-python': virtualenv => $venv }
  python::pip { 'pymysql':
    virtualenv => $venv,
    url => "git+https://github.com/anthill-utils/PyMySQL.git",
    returns => [0, 1]
  }
  python::pip { 'tormysql': virtualenv => $venv, require => Python::Pip['pymysql']}
  python::pip { 'sphinx': virtualenv => $venv }
  python::pip { 'pyjwt': virtualenv => $venv, url => "git+https://github.com/anthill-utils/pyjwt.git"}
  python::pip { 'pika': virtualenv => $venv, url => "git+https://github.com/anthill-utils/pika.git" }
  python::pip { 'pyOpenSSL': virtualenv => $venv }
  python::pip { 'cffi': virtualenv => $venv }
  python::pip { 'cryptography': virtualenv => $venv }
  python::pip { 'futures': virtualenv => $venv }
  python::pip { 'ipgetter': virtualenv => $venv }
  python::pip { 'expiringdict': virtualenv => $venv }
  python::pip { 'python-geoip': virtualenv => $venv }
  python::pip { 'python-geoip-geolite2-yplan': virtualenv => $venv }
  python::pip { 'psutil': virtualenv => $venv }
  python::pip { 'lazy': virtualenv => $venv }
}