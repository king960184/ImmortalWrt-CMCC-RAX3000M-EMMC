#!/bin/bash
#=================================================
# Description: DIY script (After first running make)
#=================================================

echo "===== diy-part2.sh 开始执行 ====="
echo "执行时间：$(date '+%Y-%m-%d %H:%M:%S %Z')"

# ── 1. 修改 LAN 默认 IP ───────────────────────────────────────────────

CONFIG_FILE="package/base-files/files/bin/config_generate"

if [[ -f "$CONFIG_FILE" ]]; then
    if grep -q "10\.0\.0\.1" "$CONFIG_FILE"; then
        echo "LAN IP 已是 10.0.0.1，无需修改"
    else
        echo "修改 LAN 默认 IP → 10.0.0.1 ..."
        sed -i \
            -e 's/192\.168\.1\.1/10.0.0.1/g' \
            -e 's/192\.168\.6\.1/10.0.0.1/g' \
            -e 's/192\.168\.0\.1/10.0.0.1/g' \
            -e 's/192\.168\.100\.1/10.0.0.1/g' \
            "$CONFIG_FILE" 2>/dev/null || echo "  sed 执行出现问题"
        # 同步修改网段
        sed -i 's/192.168.1.0/10.0.0.0/g' "$CONFIG_FILE"
        sed -i 's/192.168.1.255/10.0.0.255/g' "$CONFIG_FILE"
    fi
else
    echo "⚠️  未找到 config_generate，跳过 IP 修改"
fi

echo -e "\n===== diy-part2.sh 执行结束 ====="
echo ""