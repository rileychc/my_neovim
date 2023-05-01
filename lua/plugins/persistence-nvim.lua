return {


    -- 这个插件可以让你更方便地保存和恢复 NeoVim 中的会话。它可以自动保存你打开的文件、窗口布局、光标位置等信息，并在下一次启动 NeoVim 时自动恢复。
    {
        "folke/persistence.nvim",
        event = "BufReadPre",
        opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals" } },
        -- stylua: ignore
        keys = {
            { "<leader>qs", function() require("persistence").load() end,                desc = "Restore Session" },
            { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
            {
                "<leader>qd",
                function() require("persistence").stop() end,
                desc =
                "Don't Save Current Session"
            },
        },
    },




}
