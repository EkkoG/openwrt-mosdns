A [mosdns](https://github.com/IrineSistiana/mosdns) OpenWrt package.

## Build

```
tar xjf openwrt-sdk-22.03.3-x86-64_gcc-11.2.0_musl.Linux-x86_64.tar.xz
cd OpenWrt-SDK-22.03.3-x86-64_gcc-11.2.0_musl.Linux-x86_64
git clone https://github.com/EkkoG/openwrt-mosdns.git ekko/mosdns
./build.sh
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