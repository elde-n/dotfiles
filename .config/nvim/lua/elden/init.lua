require "elden.lazy"
require "elden.config"

require "elden.luau"


-- remove trailing whitespace on file save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = '*',
	command = "%s/\\s\\+$//e"
})
