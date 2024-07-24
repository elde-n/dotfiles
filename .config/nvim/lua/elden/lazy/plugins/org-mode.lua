return {
	"chipsenkbeil/org-roam.nvim",
	tag = "0.1.0",

	dependencies = {
		{
			"nvim-orgmode/orgmode",
			tag = "0.3.4"
		},

		{
			"nvim-treesitter/nvim-treesitter"
		},

		{
			"lukas-reineke/headlines.nvim",
			tag = "v4.0.1",
			config = function()
				require("headlines").setup()
			end
		}
	},

	config = function()
		local org_roam = require "org-roam"
		org_roam.setup({
			directory = "~/Documents/notes"
		})
	end
}
