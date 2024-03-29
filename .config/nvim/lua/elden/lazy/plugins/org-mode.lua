return {
	"nvim-neorg/neorg",
	-- tag = "*",
	build = ":Neorg sync-parsers",

	dependencies = {"nvim-lua/plenary.nvim"},

	config = function()
		local neorg = require "neorg"
		neorg.setup ({
			load = {
				["core.defaults"] = {}, -- Loads default behaviour
				["core.concealer"] = {}, -- Adds pretty icons to your documents
				["core.dirman"] = { -- Manages Neorg workspaces
					config = {
						workspaces = {
							notes = "~/Documents/notes"
						}
					}
				}
			}
		})
	end
}
