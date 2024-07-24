return {
	"folke/trouble.nvim",

	config = function()
		local trouble = require "trouble"
		trouble.setup({
			focus = true
		})

		vim.keymap.set('n', "<leader>dt", function()
			trouble.toggle("diagnostics")
		end)

		vim.diagnostic.config({
			--virtual_text = true,
			update_in_insert = true,

			float = {
				focusable = true,
				style = "minimal",
				border = "",
				source = "always",
				header = "",
				prefix = ""
			}
		})
	end
}
