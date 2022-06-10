#!/bin/sh
uci set uhttpd.main.interpreter='.php=/usr/bin/php-cgi'
uci add_list uhttpd.main.index_page='index.php'
uci commit uhttpd
/etc/init.d/uhttpd restart
rm -f /tmp/luci-indexcache
rm -rf /tmp/luci-modulecache

cd /
ln -s / /www/tinyfilemanager/rootfs
exit 0
