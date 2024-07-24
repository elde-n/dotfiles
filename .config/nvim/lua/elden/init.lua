require "elden.lazy"
require "elden.config"

-- remove trailing whitespace on file save
vim.api.nvim_create_autocmd({"BufWritePre"}, {
    pattern = '*',
    command = "%s/\\s\\+$//e"
})

local function get_file_extension(file_name)
	return (string.match(file_name, "%.%w*$"))
end

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
	callback = function(event)
		if event and event.file and get_file_extension(event.file) == ".lua" then
			vim.bo.filetype = "luau"
		end
	end
})

-- luau treesitter
for _, v in next, {"highlights", "indents", "folds", "injections", "locals"} do
	local fd = io.open(vim.fs.normalize("~/.local/src/tree-sitter/tree-sitter-luau/nvim-queries/" .. v .. ".scm"))
	local txt = fd:read("*a")

	fd:close()
	vim.treesitter.query.set("luau", v, txt)
end
