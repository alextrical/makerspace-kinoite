#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# #Get latest release
# # mkdir -p /usr/share/inkscape
# curl -s https://api.github.com/repos/inkstitch/inkstitch/releases/latest \
# | grep "browser_download_url.*-linux.tar.xz" \
# | cut -d : -f 2,3 \
# | tr -d \" \
# | xargs wget -qO - \
# | xz -d \
# | tar -xf - -C /usr/share/inkscape/

# # get up to date inkex version (March 18 2023)
# pip install "inkex @ git+https://gitlab.com/inkscape/extensions.git@29205f3cc6c39283e190a36d72d01ef428f668e5"

# #pip install "wxPython>=4.1.1"
# pip install -U \
#     -f https://extras.wxpython.org/wxPython4/extras/linux/gtk3/fedora-38 \
#     wxPython

# pip install backports.functools_lru_cache
# pip install networkx
# pip install shapely
# pip install lxml
# pip install appdirs
# pip install numpy
# pip install "jinja2>2.9"
# pip install requests

# # colormath - last official release: 3.0.0
# # we need already submitted fixes - so let's grab them from the github repository
# pip install "colormath @ git+https://github.com/gtaylor/python-colormath.git@4a076831fd5136f685aa7143db81eba27b2cd19a"

# pip install "flask>=2.2.0"
# pip install fonttools
# pip install "trimesh>=3.15.2"
# pip install scipy
# pip install diskcache
# pip install flask-cors
# pip install "pywinutils ; sys_platform == 'win32'"
# pip install "pywin32 ; sys_platform == 'win32'"