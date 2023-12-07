#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

mkdir /tmp/Nextcloud
#Nextcloud Desktop
curl -s https://api.github.com/repos/nextcloud-releases/desktop/releases/latest \
| grep "browser_download_url.*AppImage\"" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -nc -O /tmp/Nextcloud/Nextcloud-x86_64.AppImage -qi -

#Make executable
chmod +x /tmp/Nextcloud/Nextcloud-x86_64.AppImage

#Extract and move to Usr folder
(cd /tmp/Nextcloud && /tmp/Nextcloud/Nextcloud-x86_64.AppImage --appimage-extract)

mv /tmp/Nextcloud/squashfs-root/usr/bin/nextcloud /usr/bin/nextcloud
mv /tmp/Nextcloud/squashfs-root/usr/bin/nextcloudcmd /usr/bin/nextcloudcmd
echo "Copy to /usr/lib"
cp -rf /tmp/Nextcloud/squashfs-root/usr/lib/* /usr/lib
# yes | cp -rf /tmp/Nextcloud/squashfs-root/usr/libexec/* /usr/libexec
# mkdir -p /usr/plugins
# yes | cp -rf /tmp/Nextcloud/squashfs-root/usr/plugins/* /usr/plugins
# mkdir -p /usr/resources
# yes | cp -rf /tmp/Nextcloud/squashfs-root/usr/resources/* /usr/resources
# yes | cp -rf /tmp/Nextcloud/squashfs-root/usr/share/* /usr/share

#Setup Desktop file
mv /tmp/Nextcloud/squashfs-root/com.nextcloud.desktopclient.nextcloud.desktop /usr/share/applications/Nextcloud.desktop
sed -i 's@Exec=nextcloud@Exec=/usr/bin/nextcloud@g' /usr/share/applications/Nextcloud.desktop

