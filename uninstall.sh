#!/bin/bash

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "Please run this script as root"
    exit 1
fi

# Remove udev rules
echo "Removing udev rules..."
rm -f /etc/udev/rules.d/zenbook-dev.rules || {
    echo "Failed to remove udev rules"
    exit 1
}
udevadm control --reload-rules && udevadm trigger || {
    echo "Failed to reload udev rules"
    exit 1
}

# Remove keyd configuration
echo "Removing keyd configuration..."
rm -f /etc/keyd/zenbook-keyd.conf || {
    echo "Failed to remove keyd configuration"
    exit 1
}
systemctl disable keyd.service || {
    echo "Failed to disable keyd service"
    exit 1
}
systemctl stop keyd.service || {
    echo "Failed to stop keyd service"
    exit 1
}

# Remove marker file if exists
rm -f /var/tmp/zennbook_keyboard_attached

echo "Uninstallation completed successfully!"
echo "You may manually remove any configured KDE shortcuts in System Settings > Keyboard > Shortcuts."
