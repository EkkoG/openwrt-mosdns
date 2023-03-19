# SPDX-License-Identifier: GPL-3.0-only
#
# Copyright (C) 2021 ImmortalWrt.org

include $(TOPDIR)/rules.mk

PKG_NAME:=mosdns
PKG_VERSION:=5.1.3
PKG_RELEASE:=1

PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILE:=LICENSE
PKG_MAINTAINER:=Ekko <beijiu572@gmail.com>
PKG_HASH_AMD_64:=ba88169bf2f48f1d853bc5eb48fcdc5140586ef7988641a8ec2fa256f99b81b4
PKG_HASH_ARM_64:=6df2aee5c47f3dbb6d927b24700a141a88ee40acf254773e7e958decb4396938
# PKG_HASH_ARM_v7:=4ef52c3d38e8effe416eae2d36b95085ee6efebd6914cf3ef9c566e615da4f7f
# PKG_HASH_ARM_v6:=938a47583aaa5a7c48e44f11dfc3da9da148d0e8fcfc56133750d063cd0c263c
# PKG_HASH_ARM_v5:=b116a1810b69bf4763ebebd4c7172251d6b15710adef00ee22d3b6a9432bd5cc
# PKG_HASH_MIPS_32:=d7c10a476f2bc6625c2f658044dfe19e1f7f13aeece581d90aa620eeb823da01
# PKG_HASH_MIPSLE_32:=

# OpenWrt ARCH: arm, aarch64, i386, x86_64, mips, mipsel
# Golang ARCH: armv[5-7], armv8, 386, amd64, mips, mipsle
PKG_ARCH:=$(ARCH)
# ifeq ($(ARCH),mips)
# 	PKG_ARCH:=mips-softfloat
# 	PKG_HASH:=$(PKG_HASH_MIPS_32)
# endif
# ifeq ($(ARCH),mipsel)
# 	PKG_ARCH:=mipsle-softfloat
# 	PKG_HASH:=$(PKG_HASH_MIPSLE_32)
# endif
ifeq ($(ARCH),x86_64)
	PKG_ARCH:=amd64
	PKG_HASH:=$(PKG_HASH_AMD_64)
endif
# ifeq ($(ARCH),arm)
# 	PKG_ARCH:=arm-6
# 	PKG_HASH:=$(PKG_HASH_ARM_v6)
# 	ifneq ($(BOARD),bcm53xx)
# 		PKG_ARCH:=arm-7
# 		PKG_HASH:=$(PKG_HASH_ARM_v7)
# 	endif
# 	ifeq ($(BOARD),kirkwood)
# 		PKG_ARCH:=arm-5
# 		PKG_HASH:=$(PKG_HASH_ARM_v5)
# 	endif
# endif
ifeq ($(ARCH),aarch64)
	PKG_ARCH:=arm64
	PKG_HASH:=$(PKG_HASH_ARM_64)
endif
PKG_SOURCE:=mosdns-linux-$(PKG_ARCH).zip
PKG_SOURCE_URL:=https://github.com/IrineSistiana/mosdns/releases/download/v$(PKG_VERSION)/
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/mosdns/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=IP Addresses and Names
  TITLE:=A plug-in DNS forwarder/splitter
  URL:=https://github.com/IrineSistiana/mosdns
endef

define Package/mosdns
  $(call Package/mosdns/Default)
endef

define Package/mosdns-v5
  $(call Package/mosdns/Default)
endef

define Package/mosdns/description
	A plug-in DNS forwarder/splitter
endef

define Build/Prepare
	unzip $(DL_DIR)/$(PKG_SOURCE) -d $(DL_DIR)/mosdns
endef

define Build/Compile
	echo "$(PKG_NAME) Compile Skiped!"
endef

define Package/mosdns/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(DL_DIR)/mosdns/mosdns $(1)/usr/bin
endef

define Package/mosdns-v5/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(DL_DIR)/mosdns/mosdns $(1)/usr/bin
endef

$(eval $(call BuildPackage,mosdns))
$(eval $(call BuildPackage,mosdns-v5))
