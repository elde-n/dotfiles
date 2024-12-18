local function on_attach(client, buffer_id)
	local options = {buffer = buffer_id, remap = false}

	vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, options)
	vim.keymap.set('n', "gd", function() vim.lsp.buf.definition() end, options)

	vim.keymap.set('n', "<leader>vd", function() vim.diagnostic.open_float() end, options)

	vim.keymap.set('n', "<leader>bw", function() vim.lsp.buf.workspace_symbol() end, options)
	vim.keymap.set('n', "<leader>ba", function() vim.lsp.buf.code_action() end, options)
	vim.keymap.set('n', "<leader>br", function() vim.lsp.buf.references() end, options)
	vim.keymap.set('n', "<leader>bn", function() vim.lsp.buf.rename() end, options)

	vim.keymap.set('i', "<C-h>", function() vim.lsp.buf.signature_help() end, options)
end


local function config()
	local lsp = require "lspconfig"
	local util = require "lspconfig.util"

	local lua_lsp = {
		autostart = false,
		on_attach = on_attach,
		filetypes = { "lua" }
	}

	local luau_lsp = {
		on_attach = on_attach,
		cmd = {
			"luau-lsp", "lsp",
			"--definitions=/home/elden/.config/luau-lsp/global-types.d.lua",
			"--settings=/home/elden/.config/luau-lsp/settings.json"
		},

		filetypes = {
			--"lua", -- using lua-lsp-server instead
			"luau"
		},

		root_dir = util.root_pattern(".lua", ".luau", ".git"),
		single_file_support = true,

		settings = {
			["luau-lsp"] = {
				sourcemap = { enabled = false },
				types = { roblox = true },
				require = { mode = "relativeToFile" },

				completion = {
					suggestImports = true,

					imports = {
						enabled = true,
						requireStyle = "alwaysRelative",
						seperateGroupsWithLine = true
					}
				},

				diagnostics = {
					workspace = false,
					strictDatamodelTypes = true,
					includeDependents = true
				},

				trace = {
					server = "messages"
				},

				inlayHints = {
					functionReturnTypes = true,
					parameterTypes = true
				}
			}
		}
	}

	local shell_lsp = {
		on_attach = on_attach
	}

	local python_lsp = {
		on_attach = on_attach,
		settings = {
			pylsp = {
				plugins = {
					pycodestyle = {
						ignore = { "W391", "E302" },
						maxLineLength = 100
					},
					flake8 = {
						enabled = true,
						ignore = { "E302" }
					},
					pylint = { enabled = true }
				}
			}
		}
	}

	local go_lsp = {
		on_attach = on_attach
	}

	local c_cpp_lsp = {
		on_attach = on_attach
	}

	local make_lsp = {
		on_attach = on_attach
	}

	local cmake_lsp = {
		on_attach = on_attach
	}

	local rust_lsp = {
		on_attach = on_attach
	}

	lsp.lua_ls.setup(lua_lsp)
	lsp.luau_lsp.setup(luau_lsp)

	-- wants typescript LOL!?
	--lsp.bashls.setup(shell_lsp)
	lsp.pylsp.setup(python_lsp)

	lsp.gopls.setup(go_lsp)

	lsp.clangd.setup(c_cpp_lsp)
	--lsp.autotools_ls.setup(make_lsp) can't install autotools-language-server from pypi overlay
	lsp.cmake.setup(cmake_lsp)

	lsp.rust_analyzer.setup(rust_lsp)
end


return {
	"neovim/nvim-lspconfig",

	dependencies = {
		{
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } }
				}
			}
		}
	},

	config = config,
	init_options = {
		userLanguages = {
			rust = "html"
		}
	}
}
