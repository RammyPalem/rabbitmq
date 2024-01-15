#!/bin/bash

# Define the installation directory
INSTALL_DIR="/data/pgadmin"

# Specify your desired log file path
LOG_FILE_PATH="/data/log/pgadmin4/pgadmin4.log"

# Create the installation directory if it doesn't exist
sudo mkdir -p $INSTALL_DIR
sudo mkdir -p $LOG_FILE_PATH

# Install required packages
sudo apt update
sudo apt install -y virtualenv python3-pip uwsgi-plugin-python3

# Create a virtual environment for pgAdmin4
virtualenv $INSTALL_DIR

# Activate the virtual environment
source $INSTALL_DIR/bin/activate

# Install pgAdmin4 using pip
pip install pgadmin4

# Deactivate the virtual environment
deactivate

# Check if the pgAdmin4 files are present in the installation directory
if [ -d "$INSTALL_DIR" ] && [ -f "$INSTALL_DIR/lib/python3.*/site-packages/pgadmin4/pgAdmin4.py" ]; then
    echo "pgAdmin4 installed successfully in $INSTALL_DIR."
else
    echo "Error: pgAdmin4 installation failed or files are missing."
    exit 1
fi

# Continue with your configuration and uWSGI setup...

# Specify the log file path in the template (config_local.erb)
cat <<EOF | sudo tee $INSTALL_DIR/config_local.erb
<%
# Path to the log file
log_file_path = '$LOG_FILE_PATH'
%>

import os

LOG_FILE = "<%= log_file_path %>"
EOF

# Generate the pgAdmin4 configuration file from the template
sudo erb $INSTALL_DIR/config_local.erb > $INSTALL_DIR/config_local.py

# Ensure proper permissions
sudo chown $USER:$USER $INSTALL_DIR/config_local.py
sudo chmod 644 $INSTALL_DIR/config_local.py

# Configure uWSGI
cat <<EOF | sudo tee $INSTALL_DIR/uwsgi.ini
[uwsgi]
http-timeout = 86400
processes = 4
threads = 2
uid = $USER
gid = $USER
single-interpreter = true
enable-threads = true
plugin = python3
wsgi-file = $INSTALL_DIR/lib/python3.*/site-packages/pgadmin4/pgAdmin4.py
callable = app
EOF

# Run uWSGI
cd $INSTALL_DIR
sudo -u $USER uwsgi --ini uwsgi.ini
