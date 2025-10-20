#!/bin/bash
# .local/bin

function keyboard_connected() {
    sleep 2
    [ "$(lsusb | grep '0b05:1bf2')" ]
}

function turn_on() {
    notify-send -a 'ASUS Zenbook' -i preferences-desktop-screensaver -c 'device.remove' 'Turn ON Second-Screen'
    kscreen-doctor output.eDP-2.enable
}

function turn_off() {
    notify-send -a 'ASUS Zenbook' -i system-lock-screen -c 'device.add' 'Turn OFF Second-Screen'
    kscreen-doctor output.eDP-2.disable
}

function auto_toggle() {
    if keyboard_connected; then
        turn_off
    else
        turn_on
    fi
}

if [ -z "$1" ]; then
    auto_toggle
    exit 0
fi

if [ "$1" = "on" ]; then
    turn_on
elif [ "$1" = "off" ]; then
    turn_off
elif [ "$1" = "auto" ]; then
    auto_toggle
else
    notify-send -a 'ASUS Zenbook' -i preferences-desktop-screensaver -c 'device.remove' "Unknow CMD $1"
fi
