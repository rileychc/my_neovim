return {
    -- 这个插件可以让你更好地管理 NeoVim 中的 buffer。它会在窗口底部显示所有打开的 buffer，你可以使用快捷键来切换不同的 buffer。
    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        keys = {
            { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",            desc = "Toggle pin" },
            { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
        },
        opts = {
            options = {
                diagnostics = "nvim_lsp",
                always_show_bufferline = false,
                diagnostics_indicator = function(_, _, diag)
                    local icons = require("config").icons.diagnostics
                    local ret = (diag.error and icons.Error .. diag.error .. " " or "")
                        .. (diag.warning and icons.Warn .. diag.warning or "")
                    return vim.trim(ret)
                end,
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "Neo-tree",
                        highlight = "Directory",
                        text_align = "left",
                    },
                },
            },
        },
    },
    -- 删除buffer缓存区
    {
        "echasnovski/mini.bufremove",
        event = "VeryLazy",
    },
}
