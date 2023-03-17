A [mosdns](https://github.com/IrineSistiana/mosdns) OpenWrt package.

## Build

```
# 以 ar71xx 平台为例
tar xjf OpenWrt-SDK-ar71xx-for-linux-x86_64-gcc-4.8-linaro_uClibc-0.9.33.2.tar.bz2
cd OpenWrt-SDK-ar71xx-*
git clone https://github.com/EkkoG/openwrt-mosdns.git ekko/mosdns
cp feeds.conf.default feeds.conf
echo "src-link ekko $(pwd)/ekko" >> feeds.conf
./scripts/feeds update mosdns
./scripts/feeds install -a -p ekko
make defconfig
make package/mosdns/download V=s
make package/mosdns/check V=s
make package/mosdns/compile V=s
```

Or use docker to build:

```
git clone https://github.com/EkkoG/openwrt-mosdns.git
cd openwrt-mosdns
docker-compose up
```

## Usage

It's recommended to use [sdm](https://github.com/EkkoG/sdm) to manage mosdns.

Add the following to `/etc/config/sdm`:

```
config sdm 'mosdns'
        option enable '1'
        option program '/usr/bin/mosdns'
        option options 'start -c /etc/mosdns/config.yaml'
        option user 'nobody'
```

then run `/etc/init.d/sdm restart`.