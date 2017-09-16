#!/usr/bin/env sh

feh --bg-scale $HOME/Pictures/background_3.png &
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
# twmnd &
xmodmap ~/.xmodmaprc
xremap .xremaprc &
redshift-gtk &
parcellite &

/usr/bin/xscreensaver -no-capture-stderr -no-splash &

xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation" 1
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Button" 2
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Timeout" 200
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Axes" 6 7 4 5
