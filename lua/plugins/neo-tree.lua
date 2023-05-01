return {
    -- file explorer
    {
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = { "MunifTanjim/nui.nvim", lazy = true }, --依赖窗口插件
        cmd = "Neotree",
        keys = {
            {
                "<leader>E",
                function()
                    require("neo-tree.command").execute({ toggle = true, dir = require("util").get_root() })
                end,
                desc = "Explorer NeoTree (root dir)",
            },
            {
                "<leader>e",
                function()
                    require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
                end,
                desc = "Explorer NeoTree (cwd)",
            },

        },
        deactivate = function()
            vim.cmd([[Neotree close]])
        end,
        init = function()
            vim.g.neo_tree_remove_legacy_commands = 1
            if vim.fn.argc() == 1 then
                local stat = vim.loop.fs_stat(vim.fn.argv(0))
                if stat and stat.type == "directory" then
                    require("neo-tree")
                end
            end
        end,
        opts = {
            filesystem = {
                bind_to_cwd = false,
                follow_current_file = true,
            },
            window = {
                mappings = {
                    ["<space>"] = "none",
                },
            },
            default_component_configs = {
                indent = {
                    with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
                    expander_collapsed = "",
                    expander_expanded = "",
                    expander_highlight = "NeoTreeExpander",
                },
            },
        },
    },
}
