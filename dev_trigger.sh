#!/bin/bash
ACTIVE_SESSION_USER=$(loginctl list-sessions | grep 'user' | awk '{print $3}')

if [ -n "$ACTIVE_SESSION_USER" ]; then
    # 获取用户的UID
    USER_ID=$(id -u "$ACTIVE_SESSION_USER")
    # 设置正确的DBUS环境变量
    DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/${USER_ID}/bus"
    # 以正确的用户身份和环境执行命令
    su - "$ACTIVE_SESSION_USER" -c "DBUS_SESSION_BUS_ADDRESS='$DBUS_SESSION_BUS_ADDRESS' systemctl --user $1 zenbook-screen"
fi
