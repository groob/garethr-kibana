class kibana::install {
  include 'git'

  if $kibana::manage_ruby == true {
    class { 'ruby':
      gems_version => latest,
    }
  }

  group { 'kibana':
    ensure => 'present'
  }
  ->
  user { 'kibana':
    gid   => 'kibana',
    shell => '/sbin/nologin',
    home  => '/opt/kibana'
  }
  ->
  vcsrepo { '/opt/kibana':
    ensure   => present,
    provider => git,
    source   => 'git://github.com/rashidkpc/Kibana.git',
    revision => 'kibana-ruby',
    owner    => 'kibana',
    group    => 'kibana',
    before   => Bundler::Install['/opt/kibana'],
  }

  bundler::install {'/opt/kibana':
  }
}
