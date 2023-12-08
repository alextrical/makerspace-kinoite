#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

#Setup Desktop file
cat > /usr/share/applications/OpenBuildsCONTROL.desktop << EOF
[Desktop Entry]
Type=Application
Name=OpenBuildsCONTROL
Comment=OpenBuildsCONTROL CNC Machine Host Software
Exec=/usr/share/appimages/OpenBuildsCONTROL.AppImage --no-sandbox %U
Icon=OpenBuildsCONTROL
Categories=Graphics;
EOF