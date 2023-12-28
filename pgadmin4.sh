#!/bin/bash

# Install required packages
sudo apt update
sudo apt install -y virtualenv python3-pip uwsgi-plugin-python3

# Create a virtual environment for pgAdmin4
sudo mkdir /opt/pgadmin
sudo chown $USER /opt/pgadmin
virtualenv /opt/pgadmin/pgadmin4

# Activate the virtual environment
source /opt/pgadmin/pgadmin4/bin/activate

# Install pgAdmin4 using pip
pip install pgadmin4

# Deactivate the virtual environment
deactivate

# Configure uWSGI
cat <<EOF | sudo tee /opt/pgadmin/pgadmin4/uwsgi.ini
[uwsgi]
http-timeout = 86400
processes = 4
threads = 2
uid = $USER
gid = $USER
single-interpreter = true
enable-threads = true
plugin = python3
wsgi-file = /opt/pgadmin/pgadmin4/lib/python3.*/site-packages/pgadmin4/pgAdmin4.py
callable = app
EOF

# Run uWSGI
cd /opt/pgadmin/pgadmin4
sudo -u $USER uwsgi --ini uwsgi.ini