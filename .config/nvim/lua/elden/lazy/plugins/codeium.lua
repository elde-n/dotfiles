return {
	"exafunction/codeium.vim",

	event = "BufEnter",

	config = function()
		--vim.keymap.set('i', "", function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
		--vim.keymap.set('i', "", function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true, silent = true })
		--vim.keymap.set('i', "", function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true, silent = true })
		--vim.keymap.set('i', "", function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
	end
}
