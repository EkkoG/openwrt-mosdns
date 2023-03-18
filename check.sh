#!/bin/sh
current_version=$(cat Makefile | grep PKG_VERSION | head -n 1 | cut -d "=" -f 2)
echo "Current version: $current_version"

latest_version=$(curl -s https://api.github.com/repos/IrineSistiana/mosdns/releases/latest | grep tag_name | cut -d '"' -f 4 | tr -d 'v')
echo "Latest version: $latest_version"

if [ "$current_version" = "$latest_version" ]; then
    echo "No update"
    exit 0
else
    wget https://github.com/IrineSistiana/mosdns/releases/download/v$latest_version/mosdns-linux-amd64.zip -O mosdns-linux-amd64.zip
    hash=$(sha256sum mosdns-linux-amd64.zip | cut -d " " -f 1)
    sed -i '' "s/PKG_HASH_AMD_64:=.*/PKG_HASH_AMD_64:=$hash/g" Makefile
    rm mosdns-linux-amd64.zip

    wget https://github.com/IrineSistiana/mosdns/releases/download/v$latest_version/mosdns-linux-arm64.zip -O mosdns-linux-arm64.zip
    hash=$(sha256sum mosdns-linux-arm64.zip | cut -d " " -f 1)
    sed -i '' "s/PKG_HASH_ARM_64:=.*/PKG_HASH_ARM_64:=$hash/g" Makefile
    rm mosdns-linux-arm64.zip

    # wget https://github.com/IrineSistiana/mosdns/releases/download/v$latest_version/mosdns-linux-arm-5.zip -O mosdns-linux-arm-5.zip
    # hash=$(sha256sum mosdns-linux-arm-5.zip | cut -d " " -f 1)
    # sed -i '' "s/PKG_HASH_ARM_v5:=.*/PKG_HASH_ARM_v5:=$hash/g" Makefile
    # rm mosdns-linux-arm-5.zip

    # wget https://github.com/IrineSistiana/mosdns/releases/download/v$latest_version/mosdns-linux-arm-6.zip -O mosdns-linux-arm-6.zip
    # hash=$(sha256sum mosdns-linux-arm-6.zip | cut -d " " -f 1)
    # sed -i '' "s/PKG_HASH_ARM_v6:=.*/PKG_HASH_ARM_v6:=$hash/g" Makefile
    # rm mosdns-linux-arm-6.zip

    # wget https://github.com/IrineSistiana/mosdns/releases/download/v$latest_version/mosdns-linux-arm-7.zip -O mosdns-linux-arm-7.zip
    # hash=$(sha256sum mosdns-linux-arm-7.zip | cut -d " " -f 1)
    # sed -i '' "s/PKG_HASH_ARM_v7:=.*/PKG_HASH_ARM_v7:=$hash/g" Makefile
    # rm mosdns-linux-arm-7.zip

    echo "Update to $latest_version"
    sed -i '' "s/PKG_VERSION:=.*/PKG_VERSION:=$latest_version/g" Makefile
fi