# 简介

本仓库包含专为增强华硕Zenbook-Duo-2025在Linux系统下功能的工具和脚本，特别针对ArchLinux KDE Plasma环境下的双屏设置优化。虽然针对此特定环境开发，但相关方法和脚本也可适配其他Linux发行版和桌面环境。


# 使用的工具和服务

- **systemd-udev.service**：用于检测硬件事件，如键盘连接/分离
- **kscreen-doctor**：用于管理显示输出

# 安装与设置

使用普通用户运行`install.sh`即可。

# 工作原理

当Zenbook-Duo键盘连接或分离时，udev会检测到事件并触发`zenbook-dev.rules`中定义的动作。

# 许可证

本项目采用MIT许可证 - 详见[LICENSE](LICENSE)文件。

# 致谢

- 灵感来自ArchWiki和各种Linux论坛
- 特别感谢systemd、keyd和KDE Plasma的开发者

# 故障排除

- 确保所有服务正常运行
- 使用`/var/log/syslog`或`journalctl`检查与udev、keyd或KDE快捷方式相关的错误日志
- 验证文件和路径权限，特别是脚本和配置文件
