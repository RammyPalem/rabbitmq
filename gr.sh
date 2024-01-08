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

# Restart services
sudo systemctl restart uwsgi
sudo systemctl restart nginx


####################################################################
[2024-01-08 18:52:43 +0000] [51835] [INFO] Starting gunicorn 20.0.4
[2024-01-08 18:52:43 +0000] [51835] [DEBUG] Arbiter booted
[2024-01-08 18:52:43 +0000] [51835] [INFO] Listening at: http://127.0.0.1:5050 (51835)
[2024-01-08 18:52:43 +0000] [51835] [INFO] Using worker: threads
[2024-01-08 18:52:43 +0000] [51837] [INFO] Booting worker with pid: 51837
[2024-01-08 18:52:43 +0000] [51837] [ERROR] Exception in worker process
Traceback (most recent call last):
  File "/usr/lib/python3/dist-packages/gunicorn/arbiter.py", line 583, in spawn_worker
    worker.init_process()
  File "/usr/lib/python3/dist-packages/gunicorn/workers/gthread.py", line 92, in init_process
    super().init_process()
  File "/usr/lib/python3/dist-packages/gunicorn/workers/base.py", line 119, in init_process
    self.load_wsgi()
  File "/usr/lib/python3/dist-packages/gunicorn/workers/base.py", line 144, in load_wsgi
    self.wsgi = self.app.wsgi()
  File "/usr/lib/python3/dist-packages/gunicorn/app/base.py", line 67, in wsgi
    self.callable = self.load()
  File "/usr/lib/python3/dist-packages/gunicorn/app/wsgiapp.py", line 49, in load
    return self.load_wsgiapp()
  File "/usr/lib/python3/dist-packages/gunicorn/app/wsgiapp.py", line 39, in load_wsgiapp
    return util.import_app(self.app_uri)
  File "/usr/lib/python3/dist-packages/gunicorn/util.py", line 383, in import_app
    mod = importlib.import_module(module)
  File "/usr/lib/python3.8/importlib/__init__.py", line 127, in import_module
    return _bootstrap._gcd_import(name[level:], package, level)
  File "<frozen importlib._bootstrap>", line 1014, in _gcd_import
  File "<frozen importlib._bootstrap>", line 991, in _find_and_load
  File "<frozen importlib._bootstrap>", line 973, in _find_and_load_unlocked
ModuleNotFoundError: No module named 'pgadmin4'
[2024-01-08 18:52:43 +0000] [51837] [INFO] Worker exiting (pid: 51837)
[2024-01-08 18:52:43 +0000] [51835] [DEBUG] 1 workers
[2024-01-08 18:52:43 +0000] [51835] [INFO] Shutting down: Master
[2024-01-08 18:52:43 +0000] [51835] [INFO] Reason: Worker failed to boot.
