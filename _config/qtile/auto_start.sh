#!/usr/bin/env sh

feh --bg-scale $HOME/.wallpaper.*
#nitrogen --restore

compton -b

#franz &
#google-musicmanager &
#openWMail &
#owncloud &
#pidgin &

# https://github.com/jonls/redshift/issues/445
# インストールし直しても直る
redshift-gtk &

#twmnd &
blueman-applet &
fcitx-autostart &
ibus-daemon -drx &
nm-applet &
pa-applet &
parcellite &
shutter &
slack &
xmodmap ~/.xmodmaprc
xremap .xremaprc &

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

# wacom
# memo: xf86-input-synaptics を入れていない状態で正常に動作している
#xinput set-prop "Wacom Intuos Pro S Finger" "libinput Natural Scrolling Enabled" 1

source ~/.config/qtile/auto_start.local.sh

