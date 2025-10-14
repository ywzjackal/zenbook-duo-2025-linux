#!/bin/bash
# .local/bin

function keyboard_connected() {
    [ "$(lsusb | grep '0b05:1bf2')" ]
}

sleep 1

if keyboard_connected; then
    notify-send -a 'ASUS Zenbook' -i preferences-desktop-keyboard -c 'device.add' 'Turn OFF Sec-Screen'
    kscreen-doctor output.eDP-2.disable
else
    notify-send -a 'ASUS Zenbook' -i preferences-desktop-keyboard -c 'device.remove' 'Turn ON Sec-Screen'
    kscreen-doctor output.eDP-2.enable
fi
