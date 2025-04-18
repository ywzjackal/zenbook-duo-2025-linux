#!/bin/bash

sleep 1

function keyboard_connected() {
    [ "$(lsusb | grep '0b05:1bf2')" ]
}

if keyboard_connected;
then
    notify-send -a 'ASUS Zenbook' -i preferences-desktop-keyboard -c 'device.add' 'Keyboard Attached!'
    kscreen-doctor output.eDP-2.disable
else
    notify-send -a 'ASUS Zenbook' -i preferences-desktop-keyboard -c 'device.remove' 'Keyboard Detached!'
    kscreen-doctor output.eDP-2.enable
fi
