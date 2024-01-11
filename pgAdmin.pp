class pgadmin4 (
  $virtualenv_path = '/opt/pgadmin4/venv',
  $socket_path = '/tmp/pgadmin4.sock',
  $log_path = '/var/log/uwsgi/pgadmin4.log',
) {

  # Install required packages
  package { ['uwsgi', 'python3-pip']:
    ensure => installed,
  }

  # Create virtual environment (optional but recommended)
  exec { 'create_virtualenv':
    command => "python3 -m venv ${virtualenv_path}",
    creates => $virtualenv_path,
  }

  # Install pgAdmin4 within the virtual environment
  exec { 'install_pgadmin4':
    command => "${virtualenv_path}/bin/pip install pgadmin4",
    require => Exec['create_virtualenv'],
  }

  # Create uWSGI configuration file
  file { '/etc/uwsgi/apps-available/pgadmin4.ini':
    ensure  => file,
    content => template('pgadmin4/pgadmin4.ini.erb'),
    require => Package['uwsgi'],
  }

  # Symbolic link to enable uWSGI configuration
  file { '/etc/uwsgi/apps-enabled/pgadmin4.ini':
    ensure => link,
    target => '/etc/uwsgi/apps-available/pgadmin4.ini',
    require => File['/etc/uwsgi/apps-available/pgadmin4.ini'],
  }

  # Initialize pgAdmin4
  exec { 'initialize_pgadmin4':
    command => "${virtualenv_path}/bin/pgadmin4 --generate-config",
    creates => "${virtualenv_path}/lib/python3.x/site-packages/pgadmin4/config_local.py",
    require => Exec['install_pgadmin4'],
  }

  # Start uWSGI service
  service { 'uwsgi':
    ensure  => running,
    enable  => true,
    require => File['/etc/uwsgi/apps-enabled/pgadmin4.ini'],
  }
}
