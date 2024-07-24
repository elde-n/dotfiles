return {}

--[[
return {
	"Exafunction/codeium.nvim",
	dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
    },

	event = "BufEnter",

	config = function()
		local codeium = require "codeium"
		codeium.setup({
			manager_path = "/home/elden/.var/app/com.codeium.Codeium/cache",
        })
		--vim.keymap.set('i', "<C-g>ca", function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
		--vim.keymap.set('i', "<C-g>cn", function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true, silent = true })
		--vim.keymap.set('i', "<C-g>cp", function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true, silent = true })
		--vim.keymap.set('i', "<C-g>cc", function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
	end
}

]]
