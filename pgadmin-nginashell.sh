#!/bin/bash

# Specify your desired log file path
LOG_FILE_PATH="/data/log/pgadmin4/pgadmin4.log"

# Create the pgAdmin4 installation directory if it doesn't exist
sudo mkdir -p /data/pgadmin

# Install required packages
sudo apt update
sudo apt install -y virtualenv python3-pip uwsgi-plugin-python3

# Create a virtual environment for pgAdmin4
virtualenv /data/pgadmin/pgadmin4

# Activate the virtual environment
source /data/pgadmin/pgadmin4/bin/activate

# Install pgAdmin4 using pip
pip install pgadmin4

# Deactivate the virtual environment
deactivate

# Create the pgAdmin4 configuration directory if it doesn't exist
sudo mkdir -p /data/pgadmin/pgadmin4/config

# Specify the log file path in the template (config_local.erb)
cat <<EOF | sudo tee /data/pgadmin/pgadmin4/config/config_local.erb
<%
# Path to the log file
log_file_path = '$LOG_FILE_PATH'
%>

import os

LOG_FILE = "<%= log_file_path %>"
EOF

# Generate the pgAdmin4 configuration file from the template
sudo erb /data/pgadmin/pgadmin4/config/config_local.erb > /data/pgadmin/pgadmin4/config/config_local.py

# Ensure proper permissions
sudo chown $USER:$USER /data/pgadmin/pgadmin4/config/config_local.py
sudo chmod 644 /data/pgadmin/pgadmin4/config/config_local.py

# Configure uWSGI
cat <<EOF | sudo tee /data/pgadmin/pgadmin4/uwsgi.ini
[uwsgi]
http-timeout = 86400
processes = 4
threads = 2
uid = $USER
gid = $USER
single-interpreter = true
enable-threads = true
plugin = python3
wsgi-file = /data/pgadmin/pgadmin4/lib/python3.*/site-packages/pgadmin4/pgAdmin4.py
callable = app
EOF

# Run uWSGI
cd /data/pgadmin/pgadmin4
sudo -u $USER uwsgi --ini uwsgi.ini