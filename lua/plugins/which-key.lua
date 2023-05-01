local Util = require("util")
return {

    -- which-key
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        -- opts = {

        -- },
        config = function()
            popup_mappings = {
                scroll_down = "<C-d>", -- binding to scroll down inside the popup
                scroll_up = "<C-u>",   -- binding to scroll up inside the popup
            }
            vim.o.timeout = true
            vim.o.timeoutlen = 500
            plugins = { spelling = true }
            require("which-key").setup(opts)
            local keymaps = {
                mode = { "n", "v" },
                ["g"] = { name = "+goto" },
                ["gz"] = { name = "+surround" },
                ["]"] = { name = "+next" },
                ["["] = { name = "+prev" },
                ["<leader><tab>"] = { name = "+tabs" },
                ["<leader>b"] = { name = "+buffer" },
                ["<leader>L"] = { name = "+Manage Nvim" },
                ["<leader>d"] = { name = "+debug" },
                ["<leader>m"] = { name = "+markdown" },
                ["<leader>g"] = { name = "+git" },
                ["<leader>gh"] = { name = "+hunks" },
                ["<leader>q"] = { name = "+quit/session" },
                ["<leader>s"] = { name = "+search" },
                ["<leader>u"] = { name = "+ui" },
                ["<leader>w"] = { name = "+windows" },
                ["<leader>c"] = { name = "+Chatgpt/C+help" },
                ["<leader>x"] = { name = "+diagnostics/quickfix" },
            }
            if Util.has("noice.nvim") then
                keymaps["<leader>n"] = { name = "+noice" }
            end
            require("which-key").register(keymaps)
        end,
    },
}
