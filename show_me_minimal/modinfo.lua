name = "Show Me (Refresh + Minimal)"
version = "2.4"
description = version
author = "Star, +Serp, Cutlass"

forumthread = ""

api_version = 10

dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false

all_clients_require_mod = true
client_only_mod = false

icon_atlas = "preview.xml"
icon = "preview.tex"

priority = 0.00666155465

server_filter_tags = { "show", "finder" }

local color_options = {
	{description = "Auto", data = -1,},
	{description = "0%", data = 0,},
	{description = "10%", data = 0.1,},
	{description = "20%", data = 0.2,},
	{description = "30%", data = 0.3,},
	{description = "40%", data = 0.4,},
	{description = "50%", data = 0.5,},
	{description = "60%", data = 0.6,},
	{description = "70%", data = 0.7,},
	{description = "80%", data = 0.8,},
	{description = "90%", data = 0.9,},
	{description = "100%", data = 1,},
}

configuration_options =
{
	{
		name = "food_style",
		label = "Food Style",
		options = 
		{
			{description = "undefined", data = 0, hover = "Default is \"long\""},
			{description = "long", data = 1, hover = "Hunger: +12.5 / Sanity: -10 / Health: +3"},
			{description = "short", data = 2, hover = "+12.5 / -10 / +3"},
		}, 
		default = 0,
	},
	{
		name = "food_order",
		label = "Food Properties Order",
		options = 
		{
			{description = "Indefined", data = 0, hover = "Default if \"interface\""},
			{description = "Interface", data = 1, hover = "Hunger / Sanity / Health"},
			{description = "Wikia", data = 2, hover = "Health / Hunger / Sanity"},
		}, 
		default = 0,
	},
	{
		name = "food_estimation",
		label = "Estimate Stale Status",
		hover = "Should we estimate the stale status?",
		options = 
		{
			{description = "Undefined", data = -1, hover = "Yes, and users may override this option."},
			{description = "No", data = 0, hover = "No, but users may override this option."},
			{description = "Yes", data = 1, hover = "Yes, but users may override this option."},
		}, 
		default = -1,
	},
	{
		name = "show_food_units",
		label = "Show Food Units",
		hover = "For example, units of meat, units of veggie etc.",
		options = 
		{
			{description = "Undefined", data = -1, hover = "Yes, and users may override this option."},
			{description = "No", data = 0, hover = "No, but users may override this option."},
			{description = "Yes", data = 1, hover = "Yes, but users may override this option."},
			{description = "Forbidden", data = 2, hover = "Server won't send food info to clients and their settings will not matter."},
		}, 
		default = -1,
	},
	{
		name = "show_uses",
		label = "Show Tools Uses",
		hover = "",
		options = 
		{
			{description = "Undefined", data = -1, hover = "Yes, and users may override this option."},
			{description = "No", data = 0, hover = "No, but users may override this option."},
			{description = "Yes", data = 1, hover = "Yes, but users may override this option."},
			{description = "Forbidden", data = 2, hover = "Server won't send this info to the clients and their settings will not matter."},
		}, 
		default = -1,
	},
	{
		name = "lang",
		label = "Language",
		--hover = "",
		options = 
		{
			{description = "Auto", data = "auto", hover = "Detect Language Pack"},
			{description = "en", data = "en", hover = "English"},
			{description = "ru", data = "ru", hover = "Russian"},
			{description = "chs", data = "chs", hover = "Simplified Chinese"},
			{description = "cht", data = "cht", hover = "Traditional Chinese"},
			{description = "br", data = "br", hover = "Brazilian Portuguese"},
			{description = "pl", data = "pl", hover = "Polish"},
			{description = "kr", data = "kr", hover = "Korean"},
			{description = "es", data = "es", hover = "Spanish"},
		}, 
		default = "auto",
	},
	{
		name = "display_hp",
		label = "Display HP",
		--hover = "",
		options = 
		{
			{description = "Auto", data = -1, hover = "Depends on installed mods."},
			{description = "No", data = 0, hover = "No, but users may override this option."},
			{description = "Yes", data = 1, hover = "Yes, but users may override this option."},
			{description = "Forbidden", data = 2, hover = "Server won't send this info to the clients and their settings will not matter."},
		}, 
		default = -1,
	},

	{
		name = "hl_color",
		label = "Color",
		hover = "This is highlighted color.",
		options = 
		{
			{description = "Pink", data = 1},
			{description = "White", data = 2},
			{description = "Green", data = 3},
		}, 
		default = 1,
	},

	{
		name = "showbundle",
		label = "Show Bundle",
		hover = "Whether to show the contents of the bundle.",
		options = 
		{
			{description = "Vanilla", data = "false"},
			{description = "Yes", data = "true"},
		},
		default = "false",
	},
}
