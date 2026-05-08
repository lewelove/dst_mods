name = "Place Closer"
description = "Place buildings and plants closer together."
author = "lewelove"
forumthread = ""
version = "0.1.0"
api_version = 10
icon_atlas = "modicon.xml"
icon = "modicon.tex"
all_clients_require_mod = true
client_only_mod = false
dst_compatible = true
server_filter_tags = {"Place Closer"}

configuration_options =
{
	{
		name = "buildings",
		label = "Buildings",
		options = {
			{description = "NONE", data = "NONE"},
			{description = "MEDIUM", data = "MEDIUM"},
			{description = "NORMAL", data = "NORMAL"},
		},
		default = "MEDIUM",
	},
	{
		name = "plants",
		label = "Plants",
		options = {
			{description = "NONE", data = "NONE"},
			{description = "MEDIUM", data = "MEDIUM"},
			{description = "NORMAL", data = "NORMAL"},
		},
		default = "MEDIUM",
	},
}
