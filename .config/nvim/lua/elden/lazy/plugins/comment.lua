return {
	"numToStr/Comment.nvim",

	config = function()
		local comment = require "Comment"
		comment.setup {
			toggler = {
				line = nil,
				block = nil
			},

			mappings = {
				basic = false,
				extra = false
			}
		}
	end
}
