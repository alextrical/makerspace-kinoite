#!/usr/bin/env bash
                                                                                                                                
# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

#Allow Passwordless Login
sed -i '1 i\auth       sufficient      pam_succeed_if.so user ingroup nopasswdlogin' usr/etc/pam.d/sddm
sed -i '1 aauth       sufficient      pam_succeed_if.so user ingroup nopasswdlogin' usr/etc/pam.d/kde

#Set Dark theme as default
kwriteconfig5 --file usr/share/kde-settings/kde-profile/default/xdg/kdeglobals --group KDE --key LookAndFeelPackage org.kde.breezedark.desktop
kwriteconfig5 --file usr/share/kde-settings/kde-profile/default/xdg/kdeglobals --group KDE --key ColorScheme BreezeDark

#Allow user to apply updates
cat > usr/etc/polkit-1/rules.d/45-polkit-allow-updates.rules << 'EOF'
/* Allow users in to update or upgrade without authentication */
polkit.addRule(function(action, subject) {
    if (action.id == "org.projectatomic.rpmostree1.upgrade" && subject.isInGroup("users")) {
        return polkit.Result.YES;
    }
});
EOF

#Set Dark theme as default
kwriteconfig5 --file usr/etc/sddm.conf --group Autologin --key User makerspace
kwriteconfig5 --file usr/etc/sddm.conf --group Autologin --key Session plasmax11.desktop 
kwriteconfig5 --file usr/etc/sddm.conf --group General --key DisplayServer x11                                                                                                                                                                              




