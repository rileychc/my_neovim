local Util = require("util")
return {
    -- fuzzy finder
    {
        "nvim-telescope/telescope.nvim",
        -- lazy = true,
        cmd = "Telescope",
        dependencies = {
            { "nvim-lua/plenary.nvim", },                    -- 这个插件可以让你更方便地在 NeoVim 中使用 Lua。它提供了一些高级的 Lua 功能，可以帮助你更好地编写和管理 Lua 代码。
            { "nvim-telescope/telescope-fzf-native.nvim", }, --辅助telescope
            build = "make",
            config = function()
                require("telescope").load_extension("fzf")
            end,
        },
        version = false, -- telescope did only one release, so use HEAD for now
        -- keys=
        -- {
        --     {"<leader>/",
        -- Util.telescope("grep_string",{cwd=false}),desc="Find in Files (cwd)"},
        -- },
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
                        ["<C-H>"] = function()
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
                        ["<C-f>"] = function(...)
                            return require("telescope.actions").preview_scrolling_down(...)
                        end,
                        ["<C-b>"] = function(...)
                            return require("telescope.actions").preview_scrolling_up(...)
                        end,
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
