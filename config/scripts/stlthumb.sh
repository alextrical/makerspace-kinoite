#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# Your code goes here.
(cd /home/runner/work/makerspace-kinoite/makerspace-kinoite/config/files && rpm2cpio https://github.com/alextrical/stl-thumb/releases/download/release/stl-thumb-0.5.0-1.x86_64.rpm | cpio -idmv)
wget https://github.com/alextrical/stl-thumb-kde/releases/download/Release/stlthumbnail.so -P /home/runner/work/makerspace-kinoite/makerspace-kinoite/config/files/usr/lib64/qt5/plugins
wget https://github.com/alextrical/stl-thumb-kde/releases/download/Release/stlthumbnail.desktop -P /home/runner/work/makerspace-kinoite/makerspace-kinoite/config/files/usr/share/kservices5