local Util = require("util")
return {
    -- fuzzy finder
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = {
            { "nvim-lua/plenary.nvim",                    lazy = true }, -- 这个插件可以让你更方便地在 NeoVim 中使用 Lua。它提供了一些高级的 Lua 功能，可以帮助你更好地编写和管理 Lua 代码。
            { "nvim-telescope/telescope-fzf-native.nvim", lazy = true }, --辅助telescope
            build = "make",
            config = function()
                require("telescope").load_extension("fzf")
            end,
        },
        version = false, -- telescope did only one release, so use HEAD for now
        keys = {
            --   {  --在插件中查找
            --     "<leader>fp",
            --     function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
            --     desc = "Find Plugin File",
            -- },--加上
            { "<leader><",       "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "All Buffer" }, --显示所有缓冲区
            {
                "<leader>?",
                Util.telescope("live_grep"),
                desc =
                "Find in Files (root dir)"
            },
            { "<leader>/",       Util.telescope("live_grep", { cwd = false }),       desc = "Find in Files (cwd)" },
            { "<leader>sW",      Util.telescope("grep_string"),                      desc = "Word (root dir)" },
            { "<leader>sw",      Util.telescope("grep_string", { cwd = false }),     desc = "Word (cwd)" },
            { "<leader>;",       "<cmd>Telescope command_history<cr>",               desc = "Command History" }, --查询历史命令
            { "<leader>:",       "<cmd>Telescope commands<cr>",                      desc = "Commands" },
            -- find
            { "<leader>,",       "<cmd>Telescope buffers<cr>",                       desc = "Buffers" },               --显示当前缓冲区
            { "<leader>>",       Util.telescope("files"),                            desc = "Find Files (root dir)" }, --全局查找
            { "<leader>.",       Util.telescope("files", { cwd = false }),           desc = "Find Files (cwd)" },
            { "<leader><space>", "<cmd>Telescope oldfiles<cr>",                      desc = "Recent files" },          --查找最近文件
            -- git
            { "<leader>gc",      "<cmd>Telescope git_commits<CR>",                   desc = "commits" },
            { "<leader>gs",      "<cmd>Telescope git_status<CR>",                    desc = "status" },
            -- search
            { "<leader>sa",      "<cmd>Telescope autocommands<cr>",                  desc = "Auto Commands" },
            { "<leader>sb",      "<cmd>Telescope current_buffer_fuzzy_find<cr>",     desc = "Buffer" },
            { "<leader>sd",      "<cmd>Telescope diagnostics<cr>",                   desc = "Diagnostics" },
            { "<leader>sg",      Util.telescope("live_grep"),                        desc = "Grep (root dir)" },
            { "<leader>sG",      Util.telescope("live_grep", { cwd = false }),       desc = "Grep (cwd)" },
            { "<leader>sh",      "<cmd>Telescope help_tags<cr>",                     desc = "Help Pages" },
            {
                "<leader>sH",
                "<cmd>Telescope highlights<cr>",
                desc =
                "Search Highlight Groups"
            },
            { "<leader>sk", "<cmd>Telescope keymaps<cr>",     desc = "Key Maps" },
            { "<leader>sM", "<cmd>Telescope man_pages<cr>",   desc = "Man Pages" },
            { "<leader>sm", "<cmd>Telescope marks<cr>",       desc = "Jump to Mark" },
            { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
            { "<leader>sR", "<cmd>Telescope resume<cr>",      desc = "Resume" },
            {
                "<leader>uC",
                Util.telescope("colorscheme", { enable_preview = true }),
                desc =
                "Colorscheme with preview"
            },
            {
                "<leader>ss",
                Util.telescope("lsp_document_symbols", {
                    symbols = {
                        "Class",
                        "Function",
                        "Method",
                        "Constructor",
                        "Interface",
                        "Module",
                        "Struct",
                        "Trait",
                        "Field",
                        "Property",
                    },
                }),
                desc = "Goto Symbol",
            },
            {
                "<leader>sS",
                Util.telescope("lsp_workspace_symbols", {
                    symbols = {
                        "Class",
                        "Function",
                        "Method",
                        "Constructor",
                        "Interface",
                        "Module",
                        "Struct",
                        "Trait",
                        "Field",
                        "Property",
                    },
                }),
                desc = "Goto Symbol (Workspace)",
            },
        },
        opts = {
            defaults = {
                prompt_prefix = " ",
                selection_caret = " ",
                --修改

                layout_strategy = "horizontal",
                layout_config = { prompt_position = "top" },
                sorting_strategy = "ascending",
                winblend = 0,
                --结束
                mappings = {
                    i = {
                        ["<C-t>"] = function(...)
                            return require("trouble.providers.telescope").open_with_trouble(...)
                        end,
                        ["<C-t>"] = function(...)
                            return require("trouble.providers.telescope").open_selected_with_trouble(...)
                        end,
                        ["<C-i>"] = function()
                            Util.telescope("find_files", { no_ignore = true })()
                        end,
                        ["<C-h>"] = function()
                            Util.telescope("find_files", { hidden = true })()
                        end,
                        ["<C-Down>"] = function(...)
                            return require("telescope.actions").cycle_history_next(...)
                        end,
                        ["<C-Up>"] = function(...)
                            return require("telescope.actions").cycle_history_prev(...)
                        end,
                        -- ["<C-F>"] = function(...)
                        --     return require("telescope.actions").preview_scrolling_down(...)
                        -- end,
                        -- ["<C-B>"] = function(...)
                        --     return require("telescope.actions").preview_scrolling_up(...)
                        -- end,
                    },
                    n = {
                        ["q"] = function(...)
                            return require("telescope.actions").close(...)
                        end,
                    },
                },
            },
        },
    },
}
