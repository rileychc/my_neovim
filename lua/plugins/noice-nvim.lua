return {
    --浮动命令行
    -- 这个插件可以让你更方便地进行文件操作。它提供了一些常用的文件操作命令，例如创建、删除、重命名、移动等。
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                },
            },
            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
            },
        },
        -- stylua: ignore
        keys = {
            {
                "<S-Enter>",
                function() require("noice").redirect(vim.fn.getcmdline()) end,
                mode = "c",
                desc =
                "Redirect Cmdline"
            },
            {
                "<leader>nl",
                function() require("noice").cmd("last") end,
                desc =
                "Noice Last Message"
            },
            {
                "<leader>nh",
                function() require("noice").cmd("history") end,
                desc =
                "Noice History"
            },
            {
                "<leader>na",
                function() require("noice").cmd("all") end,
                desc =
                "Noice All"
            },
            {
                "<C-F>",
                function() if not require("noice.lsp").scroll(4) then return "<C-f>" end end,
                silent = true,
                "Scroll forward",
                mode = {
                    "i", "n", "s" }
            },
            {
                "<C-B>",
                function() if not require("noice.lsp").scroll(-4) then return "<C-b>" end end,
                silent = true,
                "Scroll backward",
                mode = {
                    "i", "n", "s" }
            },
        },
    },
}
