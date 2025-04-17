# Introduction

This repository contains tools and scripts designed to enhance the functionality of the ASUS Zenbook-Duo-2025 on Linux, particularly focusing on improving the usability of its dual-screen setup within the ArchLinux KDE Plasma environment. Although tailored for this specific environment, the approaches and scripts may be adapted for other Linux distributions and desktop environments.

# Purpose

The primary goal is to automate the management of the secondary screen and maintain Wi-Fi connectivity stability based on the attachment status of the laptop's keyboard. When the keyboard is attached to the laptop, the secondary screen should be disabled; when detached, the secondary screen should be enabled, all while ensuring that Wi-Fi connectivity remains uninterrupted.

# Tools and Services Used

- **systemd-udev.service**: For detecting hardware events, such as keyboard attachment and detachment.

- **keyd.service**: For remapping keyboard keys to prevent Wi-Fi disconnections during keyboard detachment.

- **kscreen-doctor**: For managing display outputs.

# Installation and Setup

## 1. Setup Udev Rules

Udev rules are used to detect when the keyboard is attached or detached from the laptop.

- Copy the udev rules file to the udev rules directory:

  ```bash
  sudo cp ./zenbook-dev.rules /etc/udev/rules.d/
  ```

- Reload the udev rules and trigger them to apply changes:

  ```bash
  sudo udevadm control --reload-rules && sudo udevadm trigger
  ```

## 2. Configure Key Remapping with keyd

The `keyd` service is used to remap the WLAN key to prevent Wi-Fi disconnections when the keyboard is detached.

- Copy the keyd configuration file:

  ```bash
  sudo cp ./zenbook-keyd.conf /etc/keyd/
  ```

- Restart and enable the keyd service:

  ```bash
  sudo systemctl restart keyd.service
  sudo systemctl enable keyd.service
  ```

## 3. Set Up KDE Shortcuts

Configure KDE to run a script that toggles the secondary screen based on the keyboard attachment status.

- Copy the KDE shortcut configuration file:

  ```bash
  cp ./zenbook-duo-2025-kde.kksrc ~/.kde/share/config/kdesktopsrc
  ```

- Alternatively, manually set up the shortcut in KDE System Settings:

  - Go to `System Settings` > `Keyboard` > `Shortcuts` > `Custom Shortcuts`.

  - Create a new global shortcut that runs `/path/to/toggle_screen2.sh` with the desired shortcut key (e.g., Ctrl+Alt+Shift+D).

# How It Works

When the Zenbook-Duo keyboard is attached to or detached from the laptop, udev detects the event and triggers actions defined in `zenbook-dev.rules`. These actions create or remove a marker file (`/var/tmp/zennbook_keyboard_attached`) indicating the keyboard's attachment status.

The WLAN key event, which can cause Wi-Fi disconnections upon keyboard detachment, is remapped using `keyd` to a different key combination (Ctrl+Alt+Shift+D). This remapping prevents the disconnection.

The KDE shortcut, bound to the remapped key combination, executes `toggle_screen2.sh`, which checks the marker file to determine the keyboard's status and toggles the secondary screen accordingly using `kscreen-doctor`.

# License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

# Acknowledgments

- Inspiration and initial ideas from the ArchWiki and various Linux forums.

- Special thanks to the developers of systemd, keyd, and KDE Plasma.

# Troubleshooting

- Ensure that all services are running correctly.

- Check logs in `/var/log/syslog` or using `journalctl` for any errors related to udev, keyd, or KDE shortcuts.

- Verify file permissions and paths, especially for scripts and configuration files.
