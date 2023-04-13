return {
    -- comments
    {
        "echasnovski/mini.comment",
        event = "VeryLazy",
        opts = {
            mappings = {
                -- Toggle comment (like `gcip` - comment inner paragraph) for both
                -- Normal and Visual modes
                comment = '<A-/>',
                -- Toggle comment on current line
                comment_line = '<A-/>',
                -- Define 'comment' textobject (like `dgc` - delete whole comment block)
                textobject = '<A-/>',
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
