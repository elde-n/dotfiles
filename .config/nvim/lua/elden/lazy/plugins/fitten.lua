return {
	"luozhiya/fittencode.nvim",

	config = function()
		require("fittencode").setup()
	end
}

--[[
	event = "BufEnter",
	config = function()
		--vim.keymap.set('i', "<C-g>ca", function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
		--vim.keymap.set('i', "<C-g>cn", function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true, silent = true })
		--vim.keymap.set('i', "<C-g>cp", function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true, silent = true })
		--vim.keymap.set('i', "<C-g>cc", function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
]]
