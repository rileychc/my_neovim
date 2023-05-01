return {
    -- comments
    {
        "echasnovski/mini.comment",
        dependencies = { { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true, }, },
        event = "VeryLazy",
        opts = {
            mappings = {
                -- Toggle comment (like `gcip` - comment inner paragraph) for both
                -- Normal and Visual modes
                comment = '<C-/>',
                -- Toggle comment on current line
                comment_line = '<C-/>',
                -- Define 'comment' textobject (like `dgc` - delete whole comment block)
                textobject = '<C-/>',
            },
            hooks = {
                pre = function()
                    require("ts_context_commentstring.internal").update_commentstring({})
                end,
            },
        },
        config = function(_, opts)
            require("mini.comment").setup(opts)
        end,
    },
}
