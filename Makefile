# Tiny File Manager by prasathmani <https://tinyfilemanager.github.io>
# Copyright 2022 by lynxnexy <https://github.com/lynxnexy/luci-app-tinyfilemanager>
# This is free software, licensed under the Apache License, Version 2.0

include $(TOPDIR)/rules.mk

LUCI_TITLE:=LuCI Tiny File Manager
LUCI_PKGARCH:=all
LUCI_DEPENDS:=+php8 +php8-cgi +php8-mod-session +php8-mod-ctype +php8-mod-fileinfo +php8-mod-zip +php8-mod-iconv +coreutils-stat +php8-mod-mbstring +php8-mod-json +zoneinfo-asia

PKG_NAME:=luci-app-tinyfilemanager
PKG_VERSION:=2.4.7
PKG_RELEASE:=1

define Package/$(PKG_NAME)
	$(call Package/luci/webtemplate)
	TITLE:=$(LUCI_TITLE)
	DEPENDS:=$(LUCI_DEPENDS)
endef

define Package/$(PKG_NAME)/description
	This is Tiny File Manager for LuCI OpenWrt.
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci
	cp -pR ./luasrc/* $(1)/usr/lib/lua/luci
	$(INSTALL_DIR) $(1)/
	cp -pR ./root/* $(1)/
endef

define Package/$(PKG_NAME)/postrm
#!/bin/sh
	export DIR_PKG="tinyfilemanager"
	if [ -d /www/$DIR_PKG ] ; then
		rm -rf /www/$DIR_PKG
	fi
	unset DIR_PKG
exit 0
endef

include $(TOPDIR)/feeds/luci/luci.mk

$(eval $(call BuildPackage,$(PKG_NAME)))
