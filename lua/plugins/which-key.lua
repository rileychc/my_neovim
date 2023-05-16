local Util = require("util")
return {

    -- which-key
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            
        },
        config = function()
                       popup_mappings = {
                scroll_down = "<C-d>", -- binding to scroll down inside the popup
                scroll_up = "<C-u>",   -- binding to scroll up inside the popup
            }
            vim.o.timeout = true
            vim.o.timeoutlen = 200
            -- ignore_missing = true
            hidden = { "t", "T" }
            plugins = { spelling = true } --开启z=拼写建议
            require("which-key").setup(opts)
            local keymaps = {
                mode = { "n", "v" },
                ["g"] = { name = "+Goto" },
                ["gc"] = { name = "+Comment" },
                ["gs"] = { name = "+Show diagnostics" },
                ["<leader>s"] = { name = "+Surround" },
                ["]"] = { name = "+Next" },
                ["["] = { name = "+Prev" },
                ["<leader><tab>"] = { name = "+Tabs" },
                ["<leader>b"] = { name = "+Duffer" },
                ["<leader>L"] = { name = "+Manage Nvim" },
                ["<leader>d"] = { name = "+Debug" },
                ["<leader>m"] = { name = "+Markdown" },
                ["<leader>g"] = { name = "+Git" },
                ["<leader>t"] = { name = "+Translation" },
                -- ["<leader>gh"] = { name = "+Hunks" },
                ["<leader>q"] = { name = "+Quit/Session" },
                ["<leader>f"] = { name = "+Search" },
                ["<leader>u"] = { name = "+Ui" },
                ["<leader>w"] = { name = "+Windows" },
                ["<leader>c"] = { name = "+Chatgpt" },
                ["<leader>x"] = { name = "+Diagnostics/Quickfix" },
            }
            triggers_blacklist = {
                -- list of mode / prefixes that should never be hooked by WhichKey
                -- this is mostly relevant for keymaps that start with a native binding
                i = { "j", "k" },
                v = { "j", "k" },
              }
            if Util.has("noice.nvim") then
                keymaps["<leader>n"] = { name = "+Noice" }
            end
            require("which-key").register(keymaps)
        end,
    },
}
