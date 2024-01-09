# pgadmin4_setup.pp

# Define directories
file { ['/data/pgadmin', '/var/lib/pgadmin', '/var/log/pgadmin']:
  ensure => 'directory',
  owner  => 'nodeuser',
  group  => 'nodeuser',
  mode   => '0755',
}

# Create a Python virtual environment
exec { 'create_virtualenv':
  command => '/usr/bin/python3 -m venv /data/pgadmin/venv',
  creates => '/data/pgadmin/venv',
  user    => 'nodeuser',
  group   => 'nodeuser',
}

# Install python3-pgadmin4 and uwsgi
package { 'python3-pgadmin4':
  ensure => installed,
}

package { 'uwsgi':
  ensure => installed,
}

# Run pgAdmin's setup.py
exec { 'pgadmin_setup':
  command => '/data/pgadmin/venv/bin/python3 /data/pgadmin/venv/lib/python3.8/site-packages/pgadmin4/setup.py',
  user    => 'nodeuser',
  group   => 'nodeuser',
  creates => '/var/lib/pgadmin/pgadmin4.db',
  require => [Package['python3-pgadmin4'], Exec['create_virtualenv']],
}

# Configure uwsgi
file { '/data/pgadmin/uwsgi.ini':
  ensure  => 'file',
  owner   => 'nodeuser',
  group   => 'nodeuser',
  mode    => '0644',
  content => <<-CONTENT
[uwsgi]
socket = /tmp/pgadmin4.sock
chdir = /data/pgadmin/venv/lib/python3.8/site-packages/pgadmin4/
module = pgAdmin4:app
processes = 1
threads = 20
wsgi-file = pgAdmin4.py
mount = /pgadmin4=pgAdmin4:app
manage-script-name = true
chmod-socket = 660
  CONTENT
}

# Start uwsgi service
service { 'uwsgi':
  ensure => running,
  enable => true,
  require => [Package['uwsgi'], Exec['pgadmin_setup'], File['/data/pgadmin/uwsgi.ini']],
}

# Configure Nginx
file { '/etc/nginx/sites-available/pgadmin4':
  ensure  => 'file',
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  content => <<-CONTENT
server {
    listen 80;
    server_name internal-pgadmin.com;

    location /pgadmin4/ {
        include /etc/nginx/uwsgi_params;
        uwsgi_pass unix:/tmp/pgadmin4.sock;
    }
}
  CONTENT
}

# Enable Nginx site configuration
file { '/etc/nginx/sites-enabled/pgadmin4':
  ensure => link,
  target => '/etc/nginx/sites-available/pgadmin4',
  require => File['/etc/nginx/sites-available/pgadmin4'],
}

# Restart Nginx
service { 'nginx':
  ensure => restarted,
  require => Service['uwsgi'],
}