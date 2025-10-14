#!/bin/bash

echo "Copy user systemd file to directory:~/.config/systemd/user/"
mkdir -pv ~/.config/systemd/user/
cp zenbook-screen.service ~/.config/systemd/user/

echo "Copy toggle_screen.sh and dev_trigger.sh to ~/.local/bin/"
sudo cp toggle_screen.sh /usr/local/bin
sudo cp dev_trigger.sh /usr/local/bin

systemctl --user daemon-reload
systemctl --user enable zenbook-screen.service

echo "Copy device rules file to /etc/udev/rules.d/"
sudo cp zenbook-dev.rules /etc/udev/rules.d/

echo "Apply device rules"
sudo udevadm control --reload-rules
sudo udevadm trigger

echo "Finished."
