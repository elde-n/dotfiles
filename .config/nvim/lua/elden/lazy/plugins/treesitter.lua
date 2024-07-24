local languages = {
	'c', "cpp", "rust", "go", "zig",
	"lua", "luau", "python", "bash",
	"css", "html", "markdown", "org",

	"java",

	"cmake", "make",
	"gomod", "gosum", "qmldir",
	"toml", "json", "yaml", "xml"
}

return {
	"nvim-treesitter/nvim-treesitter",

	init = function()
		for _, language in next, languages do
			local path = string.format("/usr/lib/libtree-sitter-%s.so", language)
			if vim.filetype.match({ filename = path }) then
				vim.treesitter.language.add(language, { path = path })
			else
				-- manually install from your package-manager
				-- or use TSInstall {language}
			end
		end
	end,

	config = function()
		local tree_sissy = require "nvim-treesitter.configs"
		local parsers = require "nvim-treesitter.parsers"

		tree_sissy.setup({
			auto_install = false,
			--ignore_install = {""},

			indent = {
				enable = true
			},

			highlight = {
				enable = true
			}
		})

		local configs = parsers.get_parser_configs()
		configs.luau = {
			install_info = {
				url = vim.fs.normalize("~/.local/src/tree-sitter/tree-sitter-luau"),
				files = {"src/parser.c", "src/scanner.c"}
			}
		}
	end
}
