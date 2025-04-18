#!/bin/bash

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "Please run this script as root"
    exit 1
fi

# Install required packages
echo "Installing required packages..."
pacman -S --needed --noconfirm keyd kscreen usbutils || {
    echo "Failed to install required packages"
    exit 1
}

# Setup udev rules
#echo "Setting up udev rules..."
#cp ./zenbook-dev.rules /etc/udev/rules.d/ || {
#    echo "Failed to copy udev rules"
#    exit 1
#}
#udevadm control --reload-rules && udevadm trigger || {
#    echo "Failed to reload udev rules"
#    exit 1
#}

# Configure keyd
echo "Configuring keyd..."
cp ./zenbook-keyd.conf /etc/keyd/ || {
    echo "Failed to copy keyd configuration"
    exit 1
}
systemctl restart keyd.service || {
    echo "Failed to restart keyd service"
    exit 1
}
systemctl enable keyd.service || {
    echo "Failed to enable keyd service"
    exit 1
}

echo "Installation completed successfully!"
echo "Please configure the KDE shortcut manually in System Settings > Keyboard > Shortcuts if needed."
