local function on_attach(client, bufnr)
	local opts = {buffer = bufnr, remap = false}

	vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set('n', "gd", function() vim.lsp.buf.definition() end, opts)

	vim.keymap.set('n', "<leader>vd", function() vim.diagnostic.open_float() end, opts)

	vim.keymap.set('n', "<leader>bw", function() vim.lsp.buf.workspace_symbol() end, opts)
	vim.keymap.set('n', "<leader>ba", function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set('n', "<leader>br", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set('n', "<leader>bn", function() vim.lsp.buf.rename() end, opts)

	vim.keymap.set('i', "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end


local function config()
	local lsp = require "lspconfig"
	local util = require "lspconfig.util"

	local lua_lsp = {
		on_attach = on_attach,
		filetypes = {"lua"},

		settings = {
			Lua = {
				diagnostics = {
					globals = {"vim"}
				}
			}
		}
	}

	local luau_lsp = {
		on_attach = on_attach,
		cmd = {
			"luau-lsp", "lsp",
			"--definitions=/home/elden/.config/luau-lsp/global-types.d.lua"
		},

		filetypes = {
			"lua",
			"luau"
		},

		root_dir = util.root_pattern(".lua", ".luau", ".git"),
		single_file_support = true,

		settings = {
			Lua = {
				diagnostics = {
					globals = {"vim"}
				}
			},

			["luau-lsp"] = {
				sourcemap = {enabled = false},
				types = {roblox = true},
				require = {mode = "relativeToFile"},

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
						ignore = {"W391"},
						maxLineLength = 100
					}
				}
			}
		}
	}

	local go_lsp = {
		on_attach = on_attach
	}

	local templ_lsp = {
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

	local zig_lsp = {
		on_attach = on_attach
	}

	local typescript_lsp = {}

	local kotlin_lsp = {
		on_attach = on_attach
	}

	-- Lua
	--lsp.lua_ls.setup(lua_lsp)

	-- enable luau only for roblox

	-- Luau
	lsp.luau_lsp.setup(luau_lsp)

	lsp.bashls.setup(shell_lsp)
	lsp.pylsp.setup(python_lsp)

	lsp.gopls.setup(go_lsp)
	lsp.templ.setup(templ_lsp)

	lsp.tsserver.setup(typescript_lsp)

	-- broken hella
	--lsp.kotlin_language_server.setup(kotlin_lsp)

	lsp.clangd.setup(c_cpp_lsp)
	lsp.cmake.setup(cmake_lsp)

	lsp.rust_analyzer.setup(rust_lsp)
	lsp.zls.setup(zig_lsp)
end


return {
	"neovim/nvim-lspconfig",
	config = config
}
