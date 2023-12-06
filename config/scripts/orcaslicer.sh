#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

#OrcaSlicer
#Download
curl -s https://api.github.com/repos/SoftFever/OrcaSlicer/releases/latest \
| grep "browser_download_url.*AppImage" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -nc -O /tmp/OrcaSlicer.AppImage -qi -

#Make executable
chmod +x /tmp/OrcaSlicer.AppImage

#Extract and move to Usr folder
(cd /tmp && OrcaSlicer.AppImage --appimage-extract)
mv /tmp/squashfs-root/usr /usr
mv /tmp/squashfs-root/bin /usr/bin
mv /tmp/squashfs-root/resources /usr/resources
mv /tmp/squashfs-root/OrcaSlicer.desktop /usr/share/applications/OrcaSlicer.desktop
sed -i 's@AppRun@/usr/bin/orca-slicer@g' /usr/share/applications/OrcaSlicer.desktop
sed -i 's@Utility;@Graphics;3DGraphics;Engineering;@g' /usr/share/applications/OrcaSlicer.desktop
echo "Keywords=3D;Printing;Slicer;slice;3D;printer;convert;gcode;stl;obj;amf;SLA" >> /usr/share/applications/OrcaSlicer.desktop