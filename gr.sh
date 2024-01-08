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


[2024-01-08 19:07:54 +0000] [55185] [DEBUG] Current configuration:
  config: ./gunicorn.conf.py
  wsgi_app: None
  bind: ['127.0.0.1:5050']
  backlog: 2048
  workers: 1
  worker_class: sync
  threads: 4
  worker_connections: 1000
  max_requests: 0
  max_requests_jitter: 0
  timeout: 30
  graceful_timeout: 30
  keepalive: 2
  limit_request_line: 4094
  limit_request_fields: 100
  limit_request_field_size: 8190
  reload: False
  reload_engine: auto
  reload_extra_files: []
  spew: False
  check_config: False
  print_config: False
  preload_app: False
  sendfile: None
  reuse_port: False
  chdir: /usr/pgadmin4
  daemon: False
  raw_env: []
  pidfile: None
  worker_tmp_dir: None
  user: 1113
  group: 1001
  umask: 0
  initgroups: False
  tmp_upload_dir: None
  secure_scheme_headers: {'X-FORWARDED-PROTOCOL': 'ssl', 'X-FORWARDED-PROTO': 'https', 'X-FORWARDED-SSL': 'on'}
  forwarded_allow_ips: ['127.0.0.1']
  accesslog: None
  disable_redirect_access_to_syslog: False
  access_log_format: %(h)s %(l)s %(u)s %(t)s "%(r)s" %(s)s %(b)s "%(f)s" "%(a)s"
  errorlog: -
  loglevel: debug
  capture_output: False
  logger_class: gunicorn.glogging.Logger
  logconfig: None
  logconfig_dict: {}
  logconfig_json: None
  syslog_addr: udp://localhost:514
  syslog: False
  syslog_prefix: None
  syslog_facility: user
  enable_stdio_inheritance: False
  statsd_host: None
  dogstatsd_tags: 
  statsd_prefix: 
  proc_name: None
  default_proc_name: pgadmin4:app
  pythonpath: None
  paste: None
  on_starting: <function OnStarting.on_starting at 0x7fe944a93820>
  on_reload: <function OnReload.on_reload at 0x7fe944a93940>
  when_ready: <function WhenReady.when_ready at 0x7fe944a93a60>
  pre_fork: <function Prefork.pre_fork at 0x7fe944a93b80>
  post_fork: <function Postfork.post_fork at 0x7fe944a93ca0>
  post_worker_init: <function PostWorkerInit.post_worker_init at 0x7fe944a93dc0>
  worker_int: <function WorkerInt.worker_int at 0x7fe944a93ee0>
  worker_abort: <function WorkerAbort.worker_abort at 0x7fe944aaa040>
  pre_exec: <function PreExec.pre_exec at 0x7fe944aaa160>
  pre_request: <function PreRequest.pre_request at 0x7fe944aaa280>
  post_request: <function PostRequest.post_request at 0x7fe944aaa310>
  child_exit: <function ChildExit.child_exit at 0x7fe944aaa430>
  worker_exit: <function WorkerExit.worker_exit at 0x7fe944aaa550>
  nworkers_changed: <function NumWorkersChanged.nworkers_changed at 0x7fe944aaa670>
  on_exit: <function OnExit.on_exit at 0x7fe944aaa790>
  ssl_context: <function NewSSLContext.ssl_context at 0x7fe944aaa8b0>
  proxy_protocol: False
  proxy_allow_ips: ['127.0.0.1']
  keyfile: None
  certfile: None
  ssl_version: 2
  cert_reqs: 0
  ca_certs: None
  suppress_ragged_eofs: True
  do_handshake_on_connect: False
  ciphers: None
  raw_paste_global_conf: []
  strip_header_spaces: False
[2024-01-08 19:07:54 +0000] [55185] [INFO] Starting gunicorn 21.2.0
[2024-01-08 19:07:54 +0000] [55185] [DEBUG] Arbiter booted
[2024-01-08 19:07:54 +0000] [55185] [INFO] Listening at: http://127.0.0.1:5050 (55185)
[2024-01-08 19:07:54 +0000] [55185] [INFO] Using worker: gthread
[2024-01-08 19:07:54 +0000] [55187] [INFO] Booting worker with pid: 55187
[2024-01-08 19:07:54 +0000] [55187] [ERROR] Exception in worker process
Traceback (most recent call last):
  File "/usr/local/lib/python3.8/dist-packages/gunicorn/arbiter.py", line 609, in spawn_worker
    worker.init_process()
  File "/usr/local/lib/python3.8/dist-packages/gunicorn/workers/gthread.py", line 95, in init_process
    super().init_process()
  File "/usr/local/lib/python3.8/dist-packages/gunicorn/workers/base.py", line 134, in init_process
    self.load_wsgi()
  File "/usr/local/lib/python3.8/dist-packages/gunicorn/workers/base.py", line 146, in load_wsgi
    self.wsgi = self.app.wsgi()
  File "/usr/local/lib/python3.8/dist-packages/gunicorn/app/base.py", line 67, in wsgi
    self.callable = self.load()
  File "/usr/local/lib/python3.8/dist-packages/gunicorn/app/wsgiapp.py", line 58, in load
    return self.load_wsgiapp()
  File "/usr/local/lib/python3.8/dist-packages/gunicorn/app/wsgiapp.py", line 48, in load_wsgiapp
    return util.import_app(self.app_uri)
  File "/usr/local/lib/python3.8/dist-packages/gunicorn/util.py", line 371, in import_app
    mod = importlib.import_module(module)
  File "/usr/lib/python3.8/importlib/__init__.py", line 127, in import_module
    return _bootstrap._gcd_import(name[level:], package, level)
  File "<frozen importlib._bootstrap>", line 1014, in _gcd_import
  File "<frozen importlib._bootstrap>", line 991, in _find_and_load
  File "<frozen importlib._bootstrap>", line 973, in _find_and_load_unlocked
ModuleNotFoundError: No module named 'pgadmin4'
[2024-01-08 19:07:54 +0000] [55187] [INFO] Worker exiting (pid: 55187)
[2024-01-08 19:07:54 +0000] [55185] [ERROR] Worker (pid:55187) exited with code 3
[2024-01-08 19:07:54 +0000] [55185] [ERROR] Shutting down: Master
[2024-01-08 19:07:54 +0000] [55185] [ERROR] Reason: Worker failed to boot.
