return {
    -- snippets
    {
        "L3MON4D3/LuaSnip",
        build = (not jit.os:find("Windows"))
            and "echo -e 'NOTE: jsregexp is optional, so not a big deal if it fails to build\n'; make install_jsregexp"
            or nil,
        dependencies = {
            "rafamadriz/friendly-snippets",
            config = function()
                local snippet_path = vim.fn.stdpath("config") .. "/snips/" --我添加的路径
                if not vim.tbl_contains(vim.opt.rtp:get(), snippet_path) then
                    vim.opt.rtp:append(snippet_path)
                end

                require("luasnip.loaders.from_vscode").lazy_load()
            end,
        },
        opts = {
            history = true,
            delete_check_events = "TextChanged",
        },
        -- stylua: ignore
        -- keys = {  --被我注释
        --   {
        --     "<tab>",
        --     function()
        --       return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        --     end,
        --     expr = true, silent = true, mode = "i",
        --   },
        --   { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
        --   { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
        -- },
    },
}