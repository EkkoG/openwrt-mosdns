#!/bin/sh
cp feeds.conf.default feeds.conf
echo "src-link mosdns $(pwd)/mosdns" >> ./feeds.conf
./scripts/feeds update mosdns
make defconfig
./scripts/feeds install -a -p mosdns

make package/mosdns/download V=s
make package/mosdns/check V=s
make package/mosdns/compile V=s