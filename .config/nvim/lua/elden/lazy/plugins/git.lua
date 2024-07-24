return {
	"NeogitOrg/neogit",

	tag = "v0.0.1", -- for 0.9.x, remove tag on update?

	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
		--"ibhagwan/fzf-lua"              -- optional
	},

	config = function()
		local neogit = require "neogit"
		local diff_view = require "diffview"
		local diff_view_actions = require "diffview.actions"

		neogit.setup({
			-- sourcehut and codeberg??
			git_services = {
				["github.com"] = "https://github.com/${owner}/${repository}/compare/${branch_name}?expand=1",
				["bitbucket.org"] = "https://bitbucket.org/${owner}/${repository}/pull-requests/new?source=${branch_name}&t=1",
				["gitlab.com"] = "https://gitlab.com/${owner}/${repository}/merge_requests/new?merge_request[source_branch]=${branch_name}"
			}
		})

		diff_view.setup({
			diff_binaries = false
		})

		vim.keymap.set('n', "<leader>ng", function() neogit.open() end)
		vim.keymap.set('n', "<leader>ngd", function() diff_view_actions.open() end)
	end
}
