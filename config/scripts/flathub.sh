#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# #Change flatpak to use flathub
# flatpak remote-delete --system --force fedora
# flatpak remote-delete --user --force fedora
# flatpak remove --system --noninteractive --all
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo