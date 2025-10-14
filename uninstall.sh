#!/bin/bash

echo "Remove zenbook-screen.serivce"
systemctl --user disable zenbook-screen.service
rm ~/.config/systemd/user/zenbook-screen.service
systemctl --user daemon-reload

echo "Remove zenbook-dev.rules"
sudo rm /etc/udev/rules.d/zenbook-dev.rules
sudo udevadm control --reload-rules

echo "Remove toggle_screen.sh and dev_trigger.sh"
sudo rm /usr/local/bin/toggle_screen.sh
sudo rm /usr/local/bin/dev_trigger.sh

echo "Finished."
