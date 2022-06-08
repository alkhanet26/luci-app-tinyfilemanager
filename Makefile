# Tiny File Manager by prasathmani <https://tinyfilemanager.github.io>
# Copyright 2022 by lynxnexy <https://github.com/lynxnexy/luci-app-tinyfilemanager>
# This is free software, licensed under the Apache License, Version 2.0

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-tinyfilemanager
LUCI_TITLE:=LuCI Tiny File Manager
LUCI_PKGARCH:=all
LUCI_DEPENDS:=+php7 +php7-cgi +php7-mod-session +php7-mod-ctype +php7-mod-fileinfo +php7-mod-zip +php7-mod-iconv +php7-mod-mbstring +php7-mod-json +zoneinfo-asia 
PKG_VERSION:=2.4.7
PKG_RELEASE:=1

define Package/$(PKG_NAME)
	$(call Package/luci/webtemplate)
	TITLE:=$(LUCI_TITLE)
	DEPENDS:=$(LUCI_DEPENDS)
endef

define Package/$(PKG_NAME)/description
	LuCI Tiny File Manager
endef

define Package/luci-app-tinyfilemanager/postinst
#!/bin/sh
rm -f /tmp/luci-indexcache
rm -rf /tmp/luci-modulecache

exit 0
endef

include $(TOPDIR)/feeds/luci/luci.mk
$(eval $(call BuildPackage,$(PKG_NAME)))

# call BuildPackage - OpenWrt buildroot signature
