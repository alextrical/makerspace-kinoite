#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

mkdir /usr/share/appimages

#OpenBuilds-CONTROL 
curl -s https://api.github.com/repos/OpenBuilds/OpenBuilds-CONTROL/releases/latest \
| grep "browser_download_url.*AppImage" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -nc -O /usr/share/appimages/OpenBuilds-CONTROL.AppImage -qi -

#OrcaSlicer 
curl -s https://api.github.com/repos/SoftFever/OrcaSlicer/releases/latest \
| grep "browser_download_url.*AppImage" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -nc -O /usr/share/appimages/OrcaSlicer.AppImage -qi -
