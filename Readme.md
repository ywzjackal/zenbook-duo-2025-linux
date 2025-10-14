# Introduction

This repository contains tools and scripts designed to enhance the functionality of the ASUS Zenbook-Duo-2025 on Linux, particularly focusing on improving the usability of its dual-screen setup within the ArchLinux KDE Plasma environment. Although tailored for this specific environment, the approaches and scripts may be adapted for other Linux distributions and desktop environments.


# Tools and Services Used

- **systemd-udev.service**: For detecting hardware events, such as keyboard attachment and detachment.

- **kscreen-doctor**: For managing display outputs.

# Installation

Just run `install.sh` as normal user.

# How It Works

When the Zenbook-Duo keyboard is attached to or detached from the laptop, udev detects the event and triggers actions defined in `zenbook-dev.rules`. 

# License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

# Acknowledgments

- Inspiration and initial ideas from the ArchWiki and various Linux forums.

- Special thanks to the developers of systemd, keyd, and KDE Plasma.

# Troubleshooting

- Ensure that all services are running correctly.

- Check logs in `/var/log/syslog` or using `journalctl` for any errors related to udev, keyd, or KDE shortcuts.

- Verify file permissions and paths, especially for scripts and configuration files.
