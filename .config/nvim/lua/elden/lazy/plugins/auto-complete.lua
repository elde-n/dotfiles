return {
    "hrsh7th/nvim-cmp",

    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua"
    },

    config = function()
        local cmp = require "cmp"
        local lua_snip = require "luasnip"

        cmp.setup({
            snippet = {
                expand = function(args)
                    lua_snip.lsp_expand(args.body)
                end
            },

            mapping = cmp.mapping.preset.insert({
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-y>"] = cmp.mapping.confirm({select = true}),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),

            sources = cmp.config.sources({
                {name = "nvim_lsp"},
                {name = "luasnip"}
            }, {
				{name = "buffer"}
            })
        })
    end
}
