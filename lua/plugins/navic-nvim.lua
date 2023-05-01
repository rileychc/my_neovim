return {
    --  这个插件可以让你更方便地导航 NeoVim 中的文件。它提供了一些命令和快捷键，帮助你快速定位到指定的文件或行号。
    --cmp图标
    {
        "SmiteshP/nvim-navic",
        lazy = true,
        init = function()
            vim.g.navic_silence = true
            require("util").on_attach(function(client, buffer)
                if client.server_capabilities.documentSymbolProvider then
                    require("nvim-navic").attach(client, buffer)
                end
            end)
        end,
        opts = function()
            return {
                separator = " ",
                highlight = true,
                depth_limit = 5,
                -- icons = require("config").icons.kinds,
                icons = require("util").geticons("kind", true),
            }
        end,
    },
}
