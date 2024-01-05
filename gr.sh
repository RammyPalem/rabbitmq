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

Traceback (most recent call last):
  File "/usr/bin/pip3", line 11, in <module>
    load_entry_point('pip==20.0.2', 'console_scripts', 'pip3')()
  File "/usr/lib/python3/dist-packages/pkg_resources/__init__.py", line 490, in load_entry_point
    return get_distribution(dist).load_entry_point(group, name)
  File "/usr/lib/python3/dist-packages/pkg_resources/__init__.py", line 2854, in load_entry_point
    return ep.load()
  File "/usr/lib/python3/dist-packages/pkg_resources/__init__.py", line 2445, in load
    return self.resolve()
  File "/usr/lib/python3/dist-packages/pkg_resources/__init__.py", line 2451, in resolve
    module = __import__(self.module_name, fromlist=['__name__'], level=0)
  File "/usr/lib/python3/dist-packages/pip/_internal/cli/main.py", line 10, in <module>
    from pip._internal.cli.autocompletion import autocomplete
  File "/usr/lib/python3/dist-packages/pip/_internal/cli/autocompletion.py", line 9, in <module>
    from pip._internal.cli.main_parser import create_main_parser
  File "/usr/lib/python3/dist-packages/pip/_internal/cli/main_parser.py", line 7, in <module>
    from pip._internal.cli import cmdoptions
  File "/usr/lib/python3/dist-packages/pip/_internal/cli/cmdoptions.py", line 24, in <module>
    from pip._internal.exceptions import CommandError
  File "/usr/lib/python3/dist-packages/pip/_internal/exceptions.py", line 10, in <module>
    from pip._vendor.six import iteritems
  File "/usr/lib/python3/dist-packages/pip/_vendor/__init__.py", line 65, in <module>
    vendored("cachecontrol")
  File "/usr/lib/python3/dist-packages/pip/_vendor/__init__.py", line 36, in vendored
    __import__(modulename, globals(), locals(), level=0)
  File "<frozen importlib._bootstrap>", line 991, in _find_and_load
  File "<frozen importlib._bootstrap>", line 975, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 655, in _load_unlocked
  File "<frozen importlib._bootstrap>", line 618, in _load_backward_compatible
  File "<frozen zipimport>", line 259, in load_module
  File "/usr/share/python-wheels/CacheControl-0.12.6-py2.py3-none-any.whl/cachecontrol/__init__.py", line 9, in <module>
  File "<frozen importlib._bootstrap>", line 991, in _find_and_load
  File "<frozen importlib._bootstrap>", line 975, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 655, in _load_unlocked
  File "<frozen importlib._bootstrap>", line 618, in _load_backward_compatible
  File "<frozen zipimport>", line 259, in load_module
  File "/usr/share/python-wheels/CacheControl-0.12.6-py2.py3-none-any.whl/cachecontrol/wrapper.py", line 1, in <module>
  File "<frozen importlib._bootstrap>", line 991, in _find_and_load
  File "<frozen importlib._bootstrap>", line 975, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 655, in _load_unlocked
  File "<frozen importlib._bootstrap>", line 618, in _load_backward_compatible
  File "<frozen zipimport>", line 259, in load_module
  File "/usr/share/python-wheels/CacheControl-0.12.6-py2.py3-none-any.whl/cachecontrol/adapter.py", line 5, in <module>
  File "<frozen importlib._bootstrap>", line 991, in _find_and_load
  File "<frozen importlib._bootstrap>", line 975, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 655, in _load_unlocked
  File "<frozen importlib._bootstrap>", line 618, in _load_backward_compatible
  File "<frozen zipimport>", line 259, in load_module
  File "/usr/share/python-wheels/requests-2.22.0-py2.py3-none-any.whl/requests/__init__.py", line 95, in <module>
  File "<frozen importlib._bootstrap>", line 991, in _find_and_load
  File "<frozen importlib._bootstrap>", line 975, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 655, in _load_unlocked
  File "<frozen importlib._bootstrap>", line 618, in _load_backward_compatible
  File "<frozen zipimport>", line 259, in load_module
  File "/usr/share/python-wheels/urllib3-1.25.8-py2.py3-none-any.whl/urllib3/contrib/pyopenssl.py", line 46, in <module>
  File "/usr/lib/python3/dist-packages/OpenSSL/__init__.py", line 8, in <module>
    from OpenSSL import crypto, SSL
  File "/usr/lib/python3/dist-packages/OpenSSL/crypto.py", line 1553, in <module>
    class X509StoreFlags(object):
  File "/usr/lib/python3/dist-packages/OpenSSL/crypto.py", line 1573, in X509StoreFlags
    CB_ISSUER_CHECK = _lib.X509_V_FLAG_CB_ISSUER_CHECK
AttributeError: module 'lib' has no attribute 'X509_V_FLAG_CB_ISSUER_CHECK'
Error in sys.excepthook:
Traceback (most recent call last):
  File "/usr/lib/python3/dist-packages/apport_python_hook.py", line 72, in apport_excepthook
    from apport.fileutils import likely_packaged, get_recent_crashes
  File "/usr/lib/python3/dist-packages/apport/__init__.py", line 5, in <module>
    from apport.report import Report
  File "/usr/lib/python3/dist-packages/apport/report.py", line 32, in <module>
    import apport.fileutils
  File "/usr/lib/python3/dist-packages/apport/fileutils.py", line 12, in <module>
    import os, glob, subprocess, os.path, time, pwd, sys, requests_unixsocket
  File "/usr/lib/python3/dist-packages/requests_unixsocket/__init__.py", line 1, in <module>
    import requests
  File "<frozen importlib._bootstrap>", line 991, in _find_and_load
  File "<frozen importlib._bootstrap>", line 975, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 655, in _load_unlocked
  File "<frozen importlib._bootstrap>", line 618, in _load_backward_compatible
  File "<frozen zipimport>", line 259, in load_module
  File "/usr/share/python-wheels/requests-2.22.0-py2.py3-none-any.whl/requests/__init__.py", line 95, in <module>
  File "<frozen importlib._bootstrap>", line 991, in _find_and_load
  File "<frozen importlib._bootstrap>", line 975, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 655, in _load_unlocked
  File "<frozen importlib._bootstrap>", line 618, in _load_backward_compatible
  File "<frozen zipimport>", line 259, in load_module
  File "/usr/share/python-wheels/urllib3-1.25.8-py2.py3-none-any.whl/urllib3/contrib/pyopenssl.py", line 46, in <module>
  File "/usr/lib/python3/dist-packages/OpenSSL/__init__.py", line 8, in <module>
    from OpenSSL import crypto, SSL
  File "/usr/lib/python3/dist-packages/OpenSSL/crypto.py", line 1553, in <module>
    class X509StoreFlags(object):
  File "/usr/lib/python3/dist-packages/OpenSSL/crypto.py", line 1573, in X509StoreFlags
    CB_ISSUER_CHECK = _lib.X509_V_FLAG_CB_ISSUER_CHECK
AttributeError: module 'lib' has no attribute 'X509_V_FLAG_CB_ISSUER_CHECK'

Original exception was:
Traceback (most recent call last):
  File "/usr/bin/pip3", line 11, in <module>
    load_entry_point('pip==20.0.2', 'console_scripts', 'pip3')()
  File "/usr/lib/python3/dist-packages/pkg_resources/__init__.py", line 490, in load_entry_point
    return get_distribution(dist).load_entry_point(group, name)
  File "/usr/lib/python3/dist-packages/pkg_resources/__init__.py", line 2854, in load_entry_point
    return ep.load()
  File "/usr/lib/python3/dist-packages/pkg_resources/__init__.py", line 2445, in load
    return self.resolve()
  File "/usr/lib/python3/dist-packages/pkg_resources/__init__.py", line 2451, in resolve
    module = __import__(self.module_name, fromlist=['__name__'], level=0)
  File "/usr/lib/python3/dist-packages/pip/_internal/cli/main.py", line 10, in <module>
    from pip._internal.cli.autocompletion import autocomplete
  File "/usr/lib/python3/dist-packages/pip/_internal/cli/autocompletion.py", line 9, in <module>
    from pip._internal.cli.main_parser import create_main_parser
  File "/usr/lib/python3/dist-packages/pip/_internal/cli/main_parser.py", line 7, in <module>
    from pip._internal.cli import cmdoptions
  File "/usr/lib/python3/dist-packages/pip/_internal/cli/cmdoptions.py", line 24, in <module>
    from pip._internal.exceptions import CommandError
  File "/usr/lib/python3/dist-packages/pip/_internal/exceptions.py", line 10, in <module>
    from pip._vendor.six import iteritems
  File "/usr/lib/python3/dist-packages/pip/_vendor/__init__.py", line 65, in <module>
    vendored("cachecontrol")
  File "/usr/lib/python3/dist-packages/pip/_vendor/__init__.py", line 36, in vendored
    __import__(modulename, globals(), locals(), level=0)
  File "<frozen importlib._bootstrap>", line 991, in _find_and_load
  File "<frozen importlib._bootstrap>", line 975, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 655, in _load_unlocked
  File "<frozen importlib._bootstrap>", line 618, in _load_backward_compatible
  File "<frozen zipimport>", line 259, in load_module
  File "/usr/share/python-wheels/CacheControl-0.12.6-py2.py3-none-any.whl/cachecontrol/__init__.py", line 9, in <module>
  File "<frozen importlib._bootstrap>", line 991, in _find_and_load
  File "<frozen importlib._bootstrap>", line 975, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 655, in _load_unlocked
  File "<frozen importlib._bootstrap>", line 618, in _load_backward_compatible
  File "<frozen zipimport>", line 259, in load_module
  File "/usr/share/python-wheels/CacheControl-0.12.6-py2.py3-none-any.whl/cachecontrol/wrapper.py", line 1, in <module>
  File "<frozen importlib._bootstrap>", line 991, in _find_and_load
  File "<frozen importlib._bootstrap>", line 975, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 655, in _load_unlocked
  File "<frozen importlib._bootstrap>", line 618, in _load_backward_compatible
  File "<frozen zipimport>", line 259, in load_module
  File "/usr/share/python-wheels/CacheControl-0.12.6-py2.py3-none-any.whl/cachecontrol/adapter.py", line 5, in <module>
  File "<frozen importlib._bootstrap>", line 991, in _find_and_load
  File "<frozen importlib._bootstrap>", line 975, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 655, in _load_unlocked
  File "<frozen importlib._bootstrap>", line 618, in _load_backward_compatible
  File "<frozen zipimport>", line 259, in load_module
  File "/usr/share/python-wheels/requests-2.22.0-py2.py3-none-any.whl/requests/__init__.py", line 95, in <module>
  File "<frozen importlib._bootstrap>", line 991, in _find_and_load
  File "<frozen importlib._bootstrap>", line 975, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 655, in _load_unlocked
  File "<frozen importlib._bootstrap>", line 618, in _load_backward_compatible
  File "<frozen zipimport>", line 259, in load_module
  File "/usr/share/python-wheels/urllib3-1.25.8-py2.py3-none-any.whl/urllib3/contrib/pyopenssl.py", line 46, in <module>
  File "/usr/lib/python3/dist-packages/OpenSSL/__init__.py", line 8, in <module>
    from OpenSSL import crypto, SSL
  File "/usr/lib/python3/dist-packages/OpenSSL/crypto.py", line 1553, in <module>
    class X509StoreFlags(object):
  File "/usr/lib/python3/dist-packages/OpenSSL/crypto.py", line 1573, in X509StoreFlags
    CB_ISSUER_CHECK = _lib.X509_V_FLAG_CB_ISSUER_CHECK
AttributeError: module 'lib' has no attribute 'X509_V_FLAG_CB_ISSUER_CHECK'
