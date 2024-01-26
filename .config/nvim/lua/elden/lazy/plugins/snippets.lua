return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	build = "make install_jsregexp",

	dependencies = {"rafamadriz/friendly-snippets"},

	config = function(test)
		local snip = require "luasnip"
		snip.filetype_extend("lua", {"luadoc"})
	end
}
