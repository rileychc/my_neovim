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
    },
}
