local function get_file_extension(file_name)
	return (string.match(file_name, "%.%w*$"))
end

local function is_luau_workspace(file_path)
	local full_path = vim.uv.cwd() .. '/' .. file_path

	local directories = {
	}

	for _, entry in next, directories do
		if vim.startswith(full_path, vim.fs.normalize(entry)) then
			return true
		end
	end

	return false
end

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
	callback = function(event)
		if event and event.file and get_file_extension(event.file) == ".lua" then
			if is_luau_workspace(event.file) then
				vim.bo.filetype = "luau"
				-- lsp has autostart
			else
				local lsp = require "lspconfig"
				lsp.lua_ls.launch()
			end
		end
	end
})
