# Tiny File Manager by prasathmani <https://tinyfilemanager.github.io>
# Copyright 2022 by lynxnexy <https://github.com/lynxnexy/luci-app-tinyfilemanager>
# This is free software, licensed under the Apache License, Version 2.0

include $(TOPDIR)/rules.mk

LUCI_TITLE:=LuCI Tiny File Manager
LUCI_PKGARCH:=all
LUCI_DEPENDS:=+php7 +php7-cgi +php7-mod-session +php7-mod-ctype +php7-mod-fileinfo +php7-mod-zip +php7-mod-iconv +coreutils-stat +php7-mod-mbstring +php7-mod-json +zoneinfo-asia

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

define Package/$(PKG_NAME)/postinst
#!/bin/sh
	rm -f /tmp/luci-indexcache
	rm -rf /tmp/luci-modulecache
	uci -q set uhttpd.main.interpreter='.php=/usr/bin/php-cgi'
	uci -q add_list uhttpd.main.index_page='index.php'
	uci -q commit uhttpd

	/etc/init.d/uhttpd restart
exit 0
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
