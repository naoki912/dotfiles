#!/usr/bin/env sh

feh --bg-scale $HOME/.wallpeper.png &
#nitrogen --restore

compton -b

pa-applet &
nm-applet &
shutter &
# pidgin &
ibus-daemon -drx &
fcitx-autostart &
# google-musicmanager &
# owncloud &
slack &
franz &
# twmnd &
xmodmap ~/.xmodmaprc
xremap .xremaprc &
redshift-gtk &
parcellite &
blueman-applet &
openWMail &

/usr/bin/xscreensaver -no-capture-stderr -no-splash &

# X280
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation"         1
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Button"  2
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Timeout" 200
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Axes"    6 7 4 5

# ThinkPad X280 Natural Scrolling
xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Natural Scrolling Enabled" 1
xinput set-prop "Synaptics TM3381-002"       "libinput Natural Scrolling Enabled" 1

# タッチでクリック
xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Tapping Enabled" 1
xinput set-prop "Synaptics TM3381-002"       "libinput Tapping Enabled" 1


source ./auto_start.local.sh
