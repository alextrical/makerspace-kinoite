#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail


#OrcaSlicer
mkdir -p /usr/share/appimages
mkdir -p /tmp/OrcaSlicer

#Download
curl -s https://api.github.com/repos/SoftFever/OrcaSlicer/releases/latest \
| grep "browser_download_url.*AppImage" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -nc -O /usr/share/appimages/OrcaSlicer/OrcaSlicer.AppImage -qi -

#Make executable
chmod +x /usr/share/appimages/OrcaSlicer/OrcaSlicer.AppImage

#Extract and move to Usr folder
(cd /tmp/OrcaSlicer && /usr/share/appimages/OrcaSlicer/OrcaSlicer.AppImage --appimage-extract)
# yes | cp -rf /tmp/OrcaSlicer/squashfs-root/usr/share/* /usr/share
# yes | cp -rf /tmp/OrcaSlicer/squashfs-root/bin/* /usr/bin
# yes | cp -rf /tmp/OrcaSlicer/squashfs-root/resources/* /usr/resources
mv /tmp/OrcaSlicer/squashfs-root/usr/share/icons/hicolor/192x192/apps/* /usr/share/icons/hicolor/192x192/apps
# mv /tmp/OrcaSlicer/squashfs-root/bin/* /usr/bin
# mv /tmp/OrcaSlicer/squashfs-root/resources /usr/resources

#Setup Desktop file
mv /tmp/OrcaSlicer/squashfs-root/OrcaSlicer.desktop /usr/share/applications/OrcaSlicer.desktop
sed -i 's@AppRun@/usr/bin/orca-slicer@g' /usr/share/applications/OrcaSlicer.desktop
sed -i 's@Utility;@Graphics;3DGraphics;Engineering;@g' /usr/share/applications/OrcaSlicer.desktop
echo "Keywords=3D;Printing;Slicer;slice;3D;printer;convert;gcode;stl;obj;amf;SLA" >> /usr/share/applications/OrcaSlicer.desktop