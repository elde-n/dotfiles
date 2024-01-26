return {
	"nvim-treesitter/nvim-treesitter",

	config = function()
		local tree_sissy = require "nvim-treesitter.configs"
		local parsers = require "nvim-treesitter.parsers"

		tree_sissy.setup({
			ensure_installed = {
				"c", "cpp", "rust", "go", "luau", "python", "bash",
				"css", "elixir", "gomod", "gosum", "haskell", "json", "html",
				"java", "javascript", "typescript", "markdown", "zig", "xml",
				"yaml", "templ", "toml", "cmake", "make"
			},

			auto_install = true,
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
				url = "/home/elden/.local/src/tree-sitter/tree-sitter-luau",
				files = {"src/parser.c", "src/scanner.c"}
			}
		}
	end
}
