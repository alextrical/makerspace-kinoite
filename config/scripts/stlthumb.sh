#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# Your code goes here.
(cd /var/log && rpm2cpio https://github.com/alextrical/stl-thumb/releases/download/release/stl-thumb-0.5.0-1.x86_64.rpm | cpio -D / -idmv)
wget https://github.com/alextrical/stl-thumb-kde/releases/download/Release/stlthumbnail.so -P /usr/lib64/qt5/plugins
wget https://github.com/alextrical/stl-thumb-kde/releases/download/Release/stlthumbnail.desktop -P /usr/share/kservices5