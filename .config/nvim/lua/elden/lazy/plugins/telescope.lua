return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",

	dependencies = {
		"nvim-lua/plenary.nvim",
	},

	config = function()
		local telescope = require "telescope"
		local builtin = require "telescope.builtin"

		telescope.setup {
			pickers = {
				find_files = { theme = "ivy" },
				live_grep = { theme = "ivy" },
				help_tags = { theme = "ivy" },
				buffers = { theme = "ivy" }
			}
		}

		vim.keymap.set('n', "<leader>ff", builtin.find_files, {})
		vim.keymap.set('n', "<leader>fg", builtin.live_grep, {}) -- install 'ripgrep'
		vim.keymap.set('n', "<leader>fh", builtin.help_tags, {})
		vim.keymap.set('n', "<leader>fb", builtin.buffers, {})
	end
}
