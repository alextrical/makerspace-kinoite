#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

#Setup Desktop file
cat > /usr/share/applications/STM32CubeProgrammer.desktop << EOF
[Desktop Entry]
Type=Application
Name=STM32CubeProgrammer
Name[en]=STM32CubeProgrammer
Comment=STM32CubeProgrammer
Comment[en]=STM32CubeProgrammer
Exec=/usr/share/STMicroelectronics/STM32CubeProgrammer/bin/STM32CubeProgrammer
Icon=/usr/share/STMicroelectronics/STM32CubeProgrammer/util/Programmer.ico
Path=/usr/share/STMicroelectronics/STM32CubeProgrammer/bin
Categories=Development;
EOF

#Make executable
chmod +x /usr/share/STMicroelectronics/STM32CubeProgrammer/bin/STM32CubeProgrammer