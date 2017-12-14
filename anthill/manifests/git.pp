
class anthill::git inherits anthill {

  # apparently, there is
  apt::source { 'debian_8_git':
    location => 'http://ppa.launchpad.net/git-core/ppa/ubuntu',
    release  => 'trusty',
    repos    => 'main',
    key      => {
      'id'     => 'E1DD270288B4E6030699E45FA1715D88E1DF1F24',
      'server' => 'keyserver.ubuntu.com',
    },
    notify => Class[Apt::Update]
  } -> class { git: }

}