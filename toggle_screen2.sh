#!/bin/bash

sleep 1

if [ -e /var/tmp/zennbook_keyboard_attached ]
then
    kscreen-doctor output.eDP-2.disable
else
    kscreen-doctor output.eDP-2.enable
fi
