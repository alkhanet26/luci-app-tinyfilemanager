module("luci.controller.tinyfilemanager", package.seeall)
function index()
	entry({"admin", "nas"}, firstchild(), "NAS", 44).dependent=false
	entry({"admin", "nas", "tinyfilemanager"}, template("tinyfilemanager"), _("Tiny File Manager"), 55).dependent=true
end