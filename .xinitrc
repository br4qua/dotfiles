#!/bin/sh

# =============================================================================
# System Initialization
# =============================================================================

# Source system xinitrc.d scripts
if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# =============================================================================
# Environment Variables
# =============================================================================

# Qt/X11 environment variables
export QT_QPA_PLATFORM=xcb
export GDK_BACKEND=x11
#export QT_QPA_PLATFORMTHEME=qt6ct
export QT_QPA_PLATFORMTHEME=gtk3

# Fix Dolphin file associations for Arch
export XDG_MENU_PREFIX=arch-

# Cursor settings
#export XCURSOR_THEME=breeze_cursors
export XCURSOR_SIZE=24

# =============================================================================
# X11 Configuration
# =============================================================================

# Load X resources
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

# Ensure proper X authorization
#if [ -z "$XAUTHORITY" ]; then
#    export XAUTHORITY="$HOME/.Xauthority"
#fi

# Set cursor
xsetroot -cursor_name left_ptr

# =============================================================================
# Session Services
# =============================================================================

# Start or use existing dbus session
if test -z "$DBUS_SESSION_BUS_ADDRESS"; then
   eval "$(dbus-launch --sh-syntax --exit-with-session)"
fi

# Rebuild KDE system configuration cache
#kbuildsycoca6 --noincremental &

# XDG autostart
#/usr/lib/xdg-desktop-portal &
/usr/lib/xdg-desktop-portal-gtk &

# Polkit
/usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &

# =============================================================================
# Background Services
# =============================================================================

# Restore wallpaper
nitrogen --restore &

# Urxvt Daemon
#pgrep -q urxvtd || urxvtd -q -o -f &

# Hotkey Daemon
sxhkd &

# Music Daemon
#mkdir -p /run/user/1000/mpd/ &
#/home/free2/builds/mpd-0.24.5/build/mpd &

# =============================================================================
# Window Manager
# =============================================================================

# Current WM
exec icewm

# Alternative WMs
#exec startfluxbox
#exec openbox
#exec dwm

# =============================================================================
# Additional Desktop Components (Alternative Options)
# =============================================================================

# Taskbar / Panel
#xfce4-panel &

# Desktop File Manager
#pcmanfm-qt --desktop &

# KDE Components
#/usr/lib/kglobalacceld &
#exec kwin_x11

# OpenBox
#exec openbox

# XMonad
#xmobar &
#xmonad --recompile & 
#exec xmonad
#exec ~/.config/xmonad/xmonad-static
