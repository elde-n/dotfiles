return {
	"folke/which-key.nvim",

	event = "VeryLazy",

	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,

	--opts = {},

	config = function()
		local which_key = require "which-key"


		which_key.register({
			f = {
				name = "Telescope",
				f = {"<cmd>Telescope find_files<cr>", "Find File"},
				g = {"<cmd>Telescope live_grep<cr>", "Live Grep"},
				b = {"<cmd>Telescope buffers<cr>", "Find Buffers"},
			},

			x = {"<cmd>Explore<cr>", "Explore"}
		}, { prefix = "<leader>"})

	end
}
