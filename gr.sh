#!/bin/bash

# Update the system
sudo apt update
sudo apt upgrade -y

# Install necessary packages
sudo apt install -y python3 python3-pip virtualenv nginx

# Create a virtual environment
mkdir /opt/pgadmin4
cd /opt/pgadmin4
virtualenv venv
source venv/bin/activate

# Install pgAdmin4
pip install pgadmin4

# Set up pgAdmin4
python3 venv/lib/python3.8/site-packages/pgadmin4/setup.py

# Install uWSGI
pip install uwsgi

# Configure uWSGI
echo "[uwsgi]
module = pgAdmin4:app
master = true
processes = 5
socket = /tmp/pgadmin4.sock
chmod-socket = 660
vacuum = true" > /opt/pgadmin4/uwsgi.ini

# Create a uWSGI service
echo "[Unit]
Description=uWSGI instance to serve pgAdmin4
After=network.target

[Service]
ExecStart=/usr/local/bin/uwsgi --ini /opt/pgadmin4/uwsgi.ini
WorkingDirectory=/opt/pgadmin4
Restart=always
User=nobody
Group=nogroup

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/pgadmin4_uwsgi.service

# Start and enable the uWSGI service
sudo systemctl start pgadmin4_uwsgi
sudo systemctl enable pgadmin4_uwsgi

# Configure Nginx
echo "server {
    listen 443 ssl;
    server_name internal-pgadmin4.com;

    ssl_certificate /etc/nginx/ssl/pgadmin4.crt;
    ssl_certificate_key /etc/nginx/ssl/pgadmin4.key;

    location / {
        include uwsgi_params;
        uwsgi_pass unix:/tmp/pgadmin4.sock;
    }
}" > /etc/nginx/sites-available/pgadmin4

# Create a symbolic link to enable the Nginx configuration
sudo ln -s /etc/nginx/sites-available/pgadmin4 /etc/nginx/sites-enabled

# Test Nginx configuration
sudo nginx -t

# Restart Nginx
sudo systemctl restart nginx

echo "pgAdmin4 is now set up and can be accessed at https://internal-pgadmin4.com"