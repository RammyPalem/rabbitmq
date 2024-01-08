File "/usr/local/lib/python3.8/dist-packages/gunicorn/app/base.py", line 67, in wsgi
Jan 08 20:28:38 12345.example.com gunicorn[74769]:     self.callable = self.load()
Jan 08 20:28:38 12345.example.com gunicorn[74769]:   File "/usr/local/lib/python3.8/dist-packages/gunicorn/app/wsgiapp.py", line 58, in load
Jan 08 20:28:38 12345.example.com gunicorn[74769]:     return self.load_wsgiapp()
Jan 08 20:28:38 12345.example.com gunicorn[74769]:   File "/usr/local/lib/python3.8/dist-packages/gunicorn/app/wsgiapp.py", line 48, in load_wsgiapp
Jan 08 20:28:38 12345.example.com gunicorn[74769]:     return util.import_app(self.app_uri)
Jan 08 20:28:38 12345.example.com gunicorn[74769]:   File "/usr/local/lib/python3.8/dist-packages/gunicorn/util.py", line 371, in import_app
Jan 08 20:28:38 12345.example.com gunicorn[74769]:     mod = importlib.import_module(module)
Jan 08 20:28:38 12345.example.com gunicorn[74769]:   File "/usr/lib/python3.8/importlib/__init__.py", line 127, in import_module
Jan 08 20:28:38 12345.example.com gunicorn[74769]:     return _bootstrap._gcd_import(name[level:], package, level)
Jan 08 20:28:38 12345.example.com gunicorn[74769]:   File "<frozen importlib._bootstrap>", line 1014, in _gcd_import
Jan 08 20:28:38 12345.example.com gunicorn[74769]:   File "<frozen importlib._bootstrap>", line 991, in _find_and_load
Jan 08 20:28:38 12345.example.com gunicorn[74769]:   File "<frozen importlib._bootstrap>", line 975, in _find_and_load_unlocked
Jan 08 20:28:38 12345.example.com gunicorn[74769]:   File "<frozen importlib._bootstrap>", line 671, in _load_unlocked
Jan 08 20:28:38 12345.example.com gunicorn[74769]:   File "<frozen importlib._bootstrap_external>", line 848, in exec_module
Jan 08 20:28:38 12345.example.com gunicorn[74769]:   File "<frozen importlib._bootstrap>", line 219, in _call_with_frames_removed
Jan 08 20:28:38 12345.example.com gunicorn[74769]:   File "/usr/pgadmin4/web/pgAdmin4.py", line 49, in <module>
Jan 08 20:28:38 12345.example.com gunicorn[74769]:     import config
Jan 08 20:28:38 12345.example.com gunicorn[74769]:   File "/usr/pgadmin4/web/config.py", line 32, in <module>
Jan 08 20:28:38 12345.example.com gunicorn[74769]:     from pgadmin.utils import env, IS_WIN, fs_short_path
Jan 08 20:28:38 12345.example.com gunicorn[74769]:   File "/usr/pgadmin4/web/pgadmin/__init__.py", line 24, in <module>
Jan 08 20:28:38 12345.example.com gunicorn[74769]:     from flask import Flask, abort, request, current_app, session, url_for
Jan 08 20:28:38 12345.example.com gunicorn[74769]: ModuleNotFoundError: No module named 'flask'
Jan 08 20:28:38 12345.example.com gunicorn[74769]: [2024-01-08 20:28:38 +0000] [74769] [INFO] Worker exiting (pid: 74769)
Jan 08 20:28:38 12345.example.com gunicorn[74767]: [2024-01-08 20:28:38 +0000] [74767] [ERROR] Worker (pid:74769) exited with code 3
Jan 08 20:28:38 12345.example.com gunicorn[74767]: [2024-01-08 20:28:38 +0000] [74767] [ERROR] Shutting down: Master
Jan 08 20:28:38 12345.example.com gunicorn[74767]: [2024-01-08 20:28:38 +0000] [74767] [ERROR] Reason: Worker failed to boot.
