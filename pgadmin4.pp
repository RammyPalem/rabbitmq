# Ensure the pgAdmin4 config directory exists
file { '/opt/pgadmin/pgadmin4/config':
  ensure => directory,
}

# Create or update config_local.py
file { '/opt/pgadmin/pgadmin4/config/config_local.py':
  ensure  => file,
  content => template('pgadmin4/config_local.erb'),
  notify  => Service['nginx'], # Restart Nginx when the config changes
}

# Ensure the log directory exists
file { '/data/log/pgadmin4':
  ensure => directory,
}

# Restart pgAdmin4 when the log directory changes
file { '/opt/pgadmin/pgadmin4/bin/pgAdmin4':
  ensure  => file,
  require => File['/data/log/pgadmin4'],
  notify  => Service['nginx'],
}

# Define pgAdmin4 service restart
service { 'pgadmin4':
  ensure    => running,
  enable    => true,
  hasstatus => true,
  restart   => '/opt/pgadmin/pgadmin4/bin/pgAdmin4 restart',
}

# Add pgAdmin4 service restart command to sudoers
file { '/etc/sudoers.d/pgadmin4_restart':
  ensure  => present,
  content => 'www-data ALL=(ALL) NOPASSWD: /opt/pgadmin/pgadmin4/bin/pgAdmin4 restart',
}