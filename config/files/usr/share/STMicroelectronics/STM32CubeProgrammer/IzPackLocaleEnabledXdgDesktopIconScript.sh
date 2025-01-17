#!/bin/sh
#---------------------------------------------
#   xdg-desktop-icon
#
#   Utility script to install desktop items on a Linux desktop.
#
#   Refer to the usage() function below for usage.
#
#   Copyright 2006, Kevin Krammer <kevin.krammer@gmx.at>
#   Copyright 2006, Jeremy White <jwhite@codeweavers.com>
#
#   LICENSE:
#
#   Permission is hereby granted, free of charge, to any person obtaining a
#   copy of this software and associated documentation files (the "Software"),
#   to deal in the Software without restriction, including without limitation
#   the rights to use, copy, modify, merge, publish, distribute, sublicense,
#   and/or sell copies of the Software, and to permit persons to whom the
#   Software is furnished to do so, subject to the following conditions:
#
#   The above copyright notice and this permission notice shall be included
#   in all copies or substantial portions of the Software.
#
#   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
#   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
#   THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
#   OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
#   ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
#   OTHER DEALINGS IN THE SOFTWARE.
#
#---------------------------------------------

usage()
{
cat << _USAGE
xdg-desktop-icon - command line tool for (un)installing icons to the desktop

Synopsis

xdg-desktop-icon install [--novendor] FILE

xdg-desktop-icon uninstall FILE

xdg-desktop-icon { --help | --manual | --version }

_USAGE
}

manualpage()
{
cat << _MANUALPAGE
Name

xdg-desktop-icon - command line tool for (un)installing icons to the desktop

Synopsis

xdg-desktop-icon install [--novendor] FILE

xdg-desktop-icon uninstall FILE

xdg-desktop-icon { --help | --manual | --version }

Description

The xdg-desktop-icon program can be used to install an application launcher or
other file on the desktop of the current user.

An application launcher is represented by a *.desktop file. Desktop files are
defined by the freedesktop.org Desktop Entry Specification. The most important
aspects of *.desktop files are summarized below.

Commands

install
    Installs FILE to the desktop of the current user. FILE can be a *.desktop
    file or any other type of file.
uninstall
    Removes FILE from the desktop of the current user.

Options

--novendor

    Normally, xdg-desktop-icon checks to ensure that a *.desktop file to be
    installed has a vendor prefix. This option can be used to disable that
    check.

    A vendor prefix consists of alpha characters ([a-zA-Z]) and is terminated
    with a dash ("-"). Companies and organizations are encouraged to use a word
    or phrase, preferably the organizations name, for which they hold a
    trademark as their vendor prefix. The purpose of the vendor prefix is to
    prevent name conflicts.

--help
    Show command synopsis.
--manual
    Show this manualpage.
--version
    Show the xdg-utils version information.

Desktop Files

An application launcher can be added to the desktop by installing a *.desktop
file. A *.desktop file consists of a [Desktop Entry] header followed by several
Key=Value lines.

A *.desktop file can provide a name and description for an application in
several different languages. This is done by adding a language code as used by
LC_MESSAGES in square brackets behind the Key. This way one can specify
different values for the same Key depending on the currently selected language.

The following keys are often used:

Value=1.0
    This is a mandatory field to indicate that the *.desktop file follows the
    1.0 version of the specification.
Type=Application
    This is a mandatory field that indicates that the *.desktop file describes
    an application launcher.
Name=Application Name
    The name of the application. For example Mozilla
GenericName=Generic Name
    A generic description of the application. For example Web Browser
Comment=Comment
    Optional field to specify a tooltip for the application. For example Visit
    websites on the Internet
Icon=Icon File
    The icon to use for the application. This can either be an absolute path to
    an image file or an icon-name. If an icon-name is provided an image lookup
    by name is done in the user's current icon theme. The xdg-icon-resource
    command can be used to install image files into icon themes. The advantage
    of using an icon-name instead of an absolute path is that with an icon-name
    the application icon can be provided in several different sizes as well as
    in several differently themed styles.
Exec=Command Line
    The command line to start the application. If the application can open
    files the %f placeholder should be specified. When a file is dropped on the
    application launcher the %f is replaced with the file path of the dropped
    file. If multiple files can be specified on the command line the %F
    placeholder should be used instead of %f. If the application is able to
    open URLs in addition to local files then %u or %U can be used instead of
    %f or %F.

For a complete oveview of the *.desktop file format please visit http://
www.freedesktop.org/wiki/Standards/desktop-entry-spec

Environment Variables

xdg-desktop-icon honours the following environment variables:

XDG_UTILS_DEBUG_LEVEL
    Setting this environment variable to a non-zero numerical value makes
    xdg-desktop-icon do more verbose reporting on stderr. Setting a higher
    value increases the verbosity.

Exit Codes

An exit code of 0 indicates success while a non-zero exit code indicates
failure. The following failure codes can be returned:

1
    Error in command line syntax.
2
    One of the files passed on the command line did not exist.
3
    A required tool could not be found.
4
    The action failed.
5
    No permission to read one of the files passed on the command line.

See Also

xdg-icon-resource(1)

Examples

The company ShinyThings Inc. has developed an application named "WebMirror" and
would like to add a launcher for for on the desktop. The company will use
"shinythings" as its vendor id. In order to add the application to the desktop
there needs to be a .desktop file for the application:

shinythings-webmirror.desktop:

  [Desktop Entry]
  Encoding=UTF-8
  Type=Application

  Exec=webmirror
  Icon=shinythings-webmirror

  Name=WebMirror
  Name[nl]=WebSpiegel

Now the xdg-desktop-icon tool can be used to add the webmirror.desktop file to
the desktop:

xdg-desktop-icon install ./shinythings-webmirror.desktop

To add a README file to the desktop as well, the following command can be used:

xdg-desktop-icon install ./shinythings-README

_MANUALPAGE
}

#@xdg-utils-common@

#----------------------------------------------------------------------------
#   Common utility functions included in all XDG wrapper scripts
#----------------------------------------------------------------------------

DEBUG()
{
  [ -z "${XDG_UTILS_DEBUG_LEVEL}" ] && return 0;
  [ ${XDG_UTILS_DEBUG_LEVEL} -lt $1 ] && return 0;
  shift
  echo "$@" >&2
}

#-------------------------------------------------------------
# Exit script on successfully completing the desired operation

exit_success()
{
    if [ $# -gt 0 ]; then
        echo "$@"
        echo
    fi

    exit 0
}


#-----------------------------------------
# Exit script on malformed arguments, not enough arguments
# or missing required option.
# prints usage information

exit_failure_syntax()
{
    if [ $# -gt 0 ]; then
        echo "xdg-desktop-icon: $@" >&2
        echo "Try 'xdg-desktop-icon --help' for more information." >&2
    else
        usage
        echo "Use 'man xdg-desktop-icon' or 'xdg-desktop-icon --manual' for additional info."
    fi

    exit 1
}

#-------------------------------------------------------------
# Exit script on missing file specified on command line

exit_failure_file_missing()
{
    if [ $# -gt 0 ]; then
        echo "xdg-desktop-icon: $@" >&2
    fi

    exit 2
}

#-------------------------------------------------------------
# Exit script on failure to locate necessary tool applications

exit_failure_operation_impossible()
{
    if [ $# -gt 0 ]; then
        echo "xdg-desktop-icon: $@" >&2
    fi

    exit 3
}

#-------------------------------------------------------------
# Exit script on failure returned by a tool application

exit_failure_operation_failed()
{
    if [ $# -gt 0 ]; then
        echo "xdg-desktop-icon: $@" >&2
    fi

    exit 4
}

#------------------------------------------------------------
# Exit script on insufficient permission to read a specified file

exit_failure_file_permission_read()
{
    if [ $# -gt 0 ]; then
        echo "xdg-desktop-icon: $@" >&2
    fi

    exit 5
}

#------------------------------------------------------------
# Exit script on insufficient permission to read a specified file

exit_failure_file_permission_write()
{
    if [ $# -gt 0 ]; then
        echo "xdg-desktop-icon: $@" >&2
    fi

    exit 6
}

check_input_file()
{
    if [ ! -e "$1" ]; then
        exit_failure_file_missing "file '$1' does not exist"
    fi
    if [ ! -r "$1" ]; then
        exit_failure_file_permission_read "no permission to read file '$1'"
    fi
}

check_vendor_prefix()
{
    file_label="$2"
    [ -n "$file_label" ] || file_label="filename"
    file=`basename "$1"`
    case "$file" in
       [a-zA-Z]*-*)
         return
         ;;
    esac

    echo "xdg-desktop-icon: $file_label '$file' does not have a proper vendor prefix" >&2
    echo 'A vendor prefix consists of alpha characters ([a-zA-Z]) and is terminated' >&2
    echo 'with a dash ("-"). An example '"$file_label"' is '"'example-$file'" >&2
    echo "Use --novendor to override or 'xdg-desktop-icon --manual' for additional info." >&2
    exit 1
}

check_output_file()
{
    # if the file exists, check if it is writeable
    # if it does not exists, check if we are allowed to write on the directory
    if [ -e "$1" ]; then
        if [ ! -w "$1" ]; then
            exit_failure_file_permission_write "no permission to write to file '$1'"
        fi
    else
        DIR=`dirname "$1"`
        if [ ! -w "$DIR" -o ! -x "$DIR" ]; then
            exit_failure_file_permission_write "no permission to create file '$1'"
        fi
    fi
}

#----------------------------------------
# Checks for shared commands, e.g. --help

check_common_commands()
{
    while [ $# -gt 0 ] ; do
        parm="$1"
        shift

        case "$parm" in
            --help)
            usage
            echo "Use 'man xdg-desktop-icon' or 'xdg-desktop-icon --manual' for additional info."
            exit_success
            ;;

            --manual)
            manualpage
            exit_success
            ;;

            --version)
            echo "xdg-desktop-icon 1.0.1"
            exit_success
            ;;
        esac
    done
}

check_common_commands "$@"

[ -z "${XDG_UTILS_DEBUG_LEVEL}" ] && unset XDG_UTILS_DEBUG_LEVEL;
if [ ${XDG_UTILS_DEBUG_LEVEL-0} -lt 1 ]; then
    # Be silent
    xdg_redirect_output=" > /dev/null 2> /dev/null"
else
    # All output to stderr
    xdg_redirect_output=" >&2"
fi

#--------------------------------------
# Checks for known desktop environments
# set variable DE to the desktop environments name, lowercase

detectDE()
{
    if [ x"$KDE_FULL_SESSION" = x"true" ]; then DE=kde;
    elif [ x"$GNOME_DESKTOP_SESSION_ID" != x"" ]; then DE=gnome;
    elif xprop -root _DT_SAVE_MODE | grep ' = \"xfce4\"$' >/dev/null 2>&1; then DE=xfce;
    fi
}

#----------------------------------------------------------------------------
# kfmclient exec/openURL can give bogus exit value in KDE <= 3.5.4
# It also always returns 1 in KDE 3.4 and earlier
# Simply return 0 in such case

kfmclient_fix_exit_code()
{
    version=`kde-config --version 2>/dev/null | grep KDE`
    major=`echo $version | sed 's/KDE: \([0-9]\).*/\1/'`
    minor=`echo $version | sed 's/KDE: [0-9]*\.\([0-9]\).*/\1/'`
    release=`echo $version | sed 's/KDE: [0-9]*\.[0-9]*\.\([0-9]\).*/\1/'`
    test "$major" -gt 3 && return $1
    test "$minor" -gt 5 && return $1
    test "$release" -gt 4 && return $1
    return 0
}

install_desktop_file()
{
    if [ ! -z "$1" ]; then
        mkdir -p "$1"
        eval 'cp "$desktop_file" "$1/$basefile"'$xdg_redirect_output
# Ubuntu 10.04 needs .desktop files to be executable
        chmod u+x "$1/$basefile"
    fi
}

uninstall_desktop_file()
{
    if [ ! -z "$1" ]; then
        rm -f "$1/$basefile"
    fi
}

[ x"$1" != x"" ] || exit_failure_syntax 

action=
desktop_file=

case $1 in
  install)
    action=install
    ;;

  uninstall)
    action=uninstall
    ;;

  *)
    exit_failure_syntax "unknown command '$1'"
    ;;
esac

shift

vendor=true
while [ $# -gt 0 ] ; do
    parm=$1
    shift

    case $parm in
      --novendor)
        vendor=false
        ;;

      -*)
        exit_failure_syntax "unexpected option '$parm'"
        ;;

      *)
        if [ -n "$desktop_file" ] ; then
            exit_failure_syntax "unexpected argument '$parm'"
        fi
        if [ "$action" = "install" ] ; then
            check_input_file "$parm"
        fi
        desktop_file=$parm
        ;;
    esac
done

# Shouldn't happen
if [ -z "$action" ] ; then
    exit_failure_syntax "command argument missing"
fi

if [ -z "$desktop_file" ] ; then
    exit_failure_syntax "FILE argument missing"
fi

filetype=
case $desktop_file in
  *.desktop)
     filetype=desktop
     if [ "$vendor" = "true" -a "$action" = "install" ] ; then
        check_vendor_prefix "$desktop_file"
     fi
     ;;
  *)
     filetype=other
     ;;
esac

my_umask=077

if [ -f "$HOME/.config/user-dirs.dirs" ]; then  
  . $HOME/.config/user-dirs.dirs
#  echo "Using '$XDG_DESKTOP_DIR' as desktop"
#else
#  echo "Using default as desktop"
fi

if [ -n "$XDG_DESKTOP_DIR" ]; then
#  echo "Using '$XDG_DESKTOP_DIR' as desktop"
  desktop_dir=$XDG_DESKTOP_DIR  
else
  desktop_dir="$HOME/Desktop"
fi
#echo desktop_dir=$desktop_dir
desktop_dir_kde=`kde-config --userpath desktop 2> /dev/null`
if gconftool-2 -g /apps/nautilus/preferences/desktop_is_home_dir 2> /dev/null | grep true > /dev/null; then
    desktop_dir_gnome="$HOME"
    # Don't create $HOME/Desktop if it doesn't exist
    [ -w $desktop_dir ] || desktop_dir=
fi
if [ -n "$desktop_dir_kde" ]; then
    if [ ! -d "$desktop_dir_kde" ]; then
        save_umask=`umask`
        umask $my_umask
        mkdir -p $desktop_dir_kde
        umask $save_umask
    fi
    # Is the KDE desktop dir != $HOME/Desktop ?
    if [ x`readlink -f "$desktop_dir"` != x`readlink -f "$desktop_dir_kde"` ]; then
        # If so, don't create $HOME/Desktop if it doesn't exist
        [ -w $desktop_dir ] || desktop_dir=
    else
        desktop_dir_kde=
    fi
fi
desktop_dir_list="$desktop_dir $desktop_dir_kde $desktop_dir_gnome"

basefile=`basename "$desktop_file"`

DEBUG 1 "$action $desktop_file in $desktop_dir_list"

case $action in
    install)
        save_umask=`umask`
        umask $my_umask

        install_desktop_file "$desktop_dir"
        install_desktop_file "$desktop_dir_kde" 
        install_desktop_file "$desktop_dir_gnome" 

        umask $save_umask
        ;;

    uninstall)
        uninstall_desktop_file "$desktop_dir"
        uninstall_desktop_file "$desktop_dir_kde" 
        uninstall_desktop_file "$desktop_dir_gnome" 

        ;;
esac

exit_success



# /home/alextrical/Applications/STMicroelectronics/STM32Cube/STM32CubeProgrammer/IzPackLocaleEnabledXdgDesktopIconScript.sh
