return {
    -- statusline
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = function(plugin)
            local icons = {
                -- cmp = require("util").geticons("cmp", true),
                diagnostics = require("util").geticons("diagnostics", true),
                -- kind = require("util").geticons("kind", true),
                -- type = require("util").geticons("type", true),
                -- ui = require("util").geticons("ui", true),
                git = require("util").geticons("git", true),
            }
            -- local icons = require("config").icons
            -- local icons = require("util").geticons("ui",true)
            local function fg(name)
                return function()
                    ---@type {foreground?:number}?
                    local hl = vim.api.nvim_get_hl_by_name(name, true)
                    return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
                end
            end

            return {
                options = {
                    theme = "auto",
                    globalstatus = true,
                    disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
                },
                sections = {
                    -- lualine_x = { "😄" }, --我加入
                    lualine_a = { "mode" },
                    lualine_b = { "branch" },
                    lualine_c = {
                        {
                            "diagnostics",
                            symbols = {
                               
                                Error = icons.diagnostics.Error_alt,
                                Warn = icons.diagnostics.Warning_alt,
                                Info = icons.diagnostics.Information_alt,
                                Hint = icons.diagnostics.Hint_alt,
                            },
                        },
                        {
                            "filetype",
                            icon_only = true,
                            separator = "",
                            padding = {
                                left = 1, right = 0 }
                        },
                        { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
                        -- stylua: ignore
                        {
                            function() return require("nvim-navic").get_location() end,
                            cond = function()
                                return package.loaded["nvim-navic"] and
                                    require("nvim-navic").is_available()
                            end,
                        },
                    },
                    lualine_x = {
                        -- stylua: ignore
                        {
                            function() return require("noice").api.status.command.get() end,
                            cond = function()
                                return package.loaded["noice"] and
                                    require("noice").api.status.command.has()
                            end,
                            color = fg("Statement")
                        },
                        -- stylua: ignore
                        {
                            function() return require("noice").api.status.mode.get() end,
                            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
                            color = fg("Constant"),
                        },
                        {
                            require("lazy.status").updates,
                            cond = require("lazy.status").has_updates,
                            color = fg("Special")
                        },
                        {
                            "diff",
                            symbols = {
                                added = icons.git.Add,
                                modified = icons.git.Mod_alt,
                                removed = icons.git.Remove,
                            },
                        },
                    },
                    lualine_y = {
                        { "progress", separator = " ",                  padding = { left = 1, right = 0 } },
                        { "location", padding = { left = 0, right = 1 } },
                    },
                    lualine_z = {
                        function()
                            return " " .. os.date("%R")
                        end,
                    },
                },
                extensions = { "neo-tree" },
            }
        end,
    },
}
