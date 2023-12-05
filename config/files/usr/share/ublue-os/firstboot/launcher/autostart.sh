#!/usr/bin/env bash

#Cleanup Fedora defaults and replace with Flathub
flatpak remote-delete --system --force fedora
flatpak remote-delete --user --force fedora
flatpak remove --system --noninteractive --all
flatpak remote-add --if-not-exists --system flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo

# Simply launches the "yafti" GUI with the uBlue image's configuration.
/usr/bin/yafti /usr/share/ublue-os/firstboot/yafti.yml
