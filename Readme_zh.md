# 简介

本仓库包含专为增强华硕Zenbook-Duo-2025在Linux系统下功能的工具和脚本，特别针对ArchLinux KDE Plasma环境下的双屏设置优化。虽然针对此特定环境开发，但相关方法和脚本也可适配其他Linux发行版和桌面环境。

# 目的

主要目标是自动化管理副屏并根据键盘连接状态维持Wi-Fi连接稳定性。当键盘连接笔记本时，副屏应被禁用；当键盘分离时，副屏应被启用，同时确保Wi-Fi连接不受影响。

# 使用的工具和服务

- **systemd-udev.service**：用于检测硬件事件，如键盘连接/分离
- **keyd.service**：用于重映射键盘按键以防止键盘分离时的Wi-Fi断开
- **kscreen-doctor**：用于管理显示输出

# 安装与设置

## 1. 配置Udev规则

Udev规则用于检测键盘与笔记本的连接/分离状态。

- 将udev规则文件复制到规则目录：

  ```bash
  sudo cp ./zenbook-dev.rules /etc/udev/rules.d/
  ```

- 重新加载udev规则并触发应用更改：

  ```bash
  sudo udevadm control --reload-rules && sudo udevadm trigger
  ```

## 2. 使用keyd配置按键重映射

`keyd`服务用于将WLAN按键重映射以防止键盘分离时的Wi-Fi断开。

- 复制keyd配置文件：

  ```bash
  sudo cp ./zenbook-keyd.conf /etc/keyd/
  ```

- 重启并启用keyd服务：

  ```bash
  sudo systemctl restart keyd.service
  sudo systemctl enable keyd.service
  ```

## 3. 设置KDE快捷方式

配置KDE运行根据键盘连接状态切换副屏的脚本。

- 复制KDE快捷方式配置文件：

  ```bash
  cp ./zenbook-duo-2025-kde.kksrc ~/.kde/share/config/kdesktopsrc
  ```

- 或通过KDE系统设置手动配置：

  - 进入`系统设置` > `键盘` > `快捷方式` > `自定义快捷方式`
  - 创建新的全局快捷方式，运行`/path/to/toggle_screen2.sh`并设置快捷键（如Ctrl+Alt+Shift+D）

# 工作原理

当Zenbook-Duo键盘连接或分离时，udev会检测到事件并触发`zenbook-dev.rules`中定义的动作。这些动作会创建或删除标记文件(`/var/tmp/zennbook_keyboard_attached`)来指示键盘连接状态。

可能导致键盘分离时Wi-Fi断开的WLAN按键事件通过`keyd`被重映射为其他组合键(Ctrl+Alt+Shift+D)。这种重映射可防止断开连接。

绑定到重映射组合键的KDE快捷方式会执行`toggle_screen2.sh`，该脚本检查标记文件以确定键盘状态，并使用`kscreen-doctor`相应地切换副屏。

# 许可证

本项目采用MIT许可证 - 详见[LICENSE](LICENSE)文件。

# 致谢

- 灵感来自ArchWiki和各种Linux论坛
- 特别感谢systemd、keyd和KDE Plasma的开发者

# 故障排除

- 确保所有服务正常运行
- 使用`/var/log/syslog`或`journalctl`检查与udev、keyd或KDE快捷方式相关的错误日志
- 验证文件和路径权限，特别是脚本和配置文件
