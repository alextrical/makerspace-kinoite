#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# This script grabs the latest AppImageLauncher release
curl -s https://api.github.com/repos/TheAssassin/AppImageLauncher/releases/latest \
| grep "browser_download_url.*x86_64.rpm" \
| cut -d : -f 2,3 \
| tr -d \" \
| xargs wget - -O /tmp/appimagelauncher.x86_64.rpm
rpm-ostree install /tmp/appimagelauncher.x86_64.rpm
# rm /tmp/appimagelauncher.x86_64.rpm
