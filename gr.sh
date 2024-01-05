#!/bin/bash

# Update and install required packages
sudo apt update
sudo apt install -y python3-pip libpq-dev postgresql postgresql-contrib nginx

# Install pgAdmin4 using pip
sudo pip3 install pgadmin4

# Configure pgAdmin4
sudo /usr/local/lib/python3.8/dist-packages/pgadmin4/pgAdmin4/setup.py

# Install uWSGI
sudo apt install -y uwsgi uwsgi-plugin-python3

# Create a uWSGI configuration file
echo "[uwsgi]
http-timeout = 86400
http-timeout-asynchronous = 86400" | sudo tee /etc/uwsgi/apps-available/pgadmin.ini

# Create a symlink to enable the uWSGI app
sudo ln -s /etc/uwsgi/apps-available/pgadmin.ini /etc/uwsgi/apps-enabled/

# Configure Nginx
echo "server {
    listen 80;
    server_name abc-internal-pgadmin.com;

    location / {
        include uwsgi_params;
        uwsgi_pass unix:/run/uwsgi/app/pgadmin/socket;
    }
}" | sudo tee /etc/nginx/sites-available/pgadmin

# Create a symlink to enable the Nginx site
sudo ln -s /etc/nginx/sites-available/pgadmin /etc/nginx/sites-enabled/

# Restart services
sudo systemctl restart uwsgi
sudo systemctl restart nginx