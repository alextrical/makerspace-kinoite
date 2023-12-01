#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# This script grabs the latest mightyscape-1.2 repo
# https://github.com/eridur-de/mightyscape-1.2
mkdir -p /usr/share/inkscape/git
mkdir -p /usr/share/inkscape/extensions
git clone https://gitea.fablabchemnitz.de/FabLab_Chemnitz/mightyscape-1.2.git /usr/share/inkscape/git/mightyscape-1.2
mv /usr/share/inkscape/git/mightyscape-1.2/extensions/fablabchemnitz /usr/share/inkscape/extensions/fablab
#pip install -r /usr/share/inkscape/git/mightyscape-1.2/requirements.txt
#python -m pip install --upgrade pip #upgrade pip first
#pip install --upgrade --quiet --no-cache-dir -r /usr/share/inkscape/requirements.txt
#cat /usr/share/inkscape/requirements.txt | sed '/^#/d' | xargs -n 1 pip install --upgrade --quiet --no-cache-dir #use this in case the previous command failed (skip errors)
rm -rf /usr/share/inkscape/git

# This script grabs the latest inkstitch release
curl -s https://api.github.com/repos/inkstitch/inkstitch/releases/latest \
| grep "browser_download_url.*-linux.tar.xz" \
| cut -d : -f 2,3 \
| tr -d \" \
| xargs wget -qO - \
| xz -d \
| tar -xf - -C /usr/share/inkscape/

# #Requirements
# pip install debugpy
# pip install lxml
# pip install moderngl
# pip install numpy
# pip install networkx 
# pip install opencv-python
# pip install pyclipper
# pip install pillow 
# pip install scipy 
# pip install scour 
# pip install shapely 
# pip install svg-to-gcode 
# pip install svgpathtools 
# pip install vpype 
# pip install vpype-dxf 
# #GitPython required by mightyscape updater extension
# pip install GitPython
# pip install wheel 
# pip install pytesseract
# pip install cairosvg
# pip install PyQt5
# pip install PySide6
# #brother_ql required by iventory_sticker extension
# pip install brother_ql 
# #cssselect required by boxes.py and mightyscape updater extension
# pip install cssselect
# #affine required by boxes.py extension
# pip install affine
# #pip install openmesh #Removed as it crashes on install
# wget https://gitlab.vci.rwth-aachen.de:9000/OpenMesh/openmesh-python/-/jobs/artifacts/master/download?job=deploy-3.9-linux -O "openmesh.zip"
# unzip "openmesh.zip"
# rm -f "openmesh.zip"
# pip install 


# #vpype occult plugin setup
# pip install git+https://github.com/abey79/occult.git#egg=occult

# #vpype deduplicate plugin setup
# pip install tqdm
# pip install git+https://github.com/LoicGoulefert/deduplicate.git#egg=deduplicate

# #plycutter
# pip install git+https://github.com/tjltjl/plycutter.git