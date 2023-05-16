return {
    --这个插件可以让你更方便地在 NeoVim 中进行跳转。它提供了一些快速跳转的命令和快捷键，让你更容易地浏览和编辑代码。
    {
        "ggandor/leap.nvim",
        event="VeryLazy",
        keys = {
            { "s",  mode = { "n", "x", "o" }, desc = "Leap forward to" },
            { "S",  mode = { "n", "x", "o" }, desc = "Leap backward to" },
            -- { "<leader>ws", mode = { "n", "x", "o" }, desc = "Leap from windows" },--窗口跳转
        },
        config = function(_, opts)
            local leap = require("leap")
            for k, v in pairs(opts) do
                leap.opts[k] = v
            end
            leap.add_default_mappings(true)
            vim.keymap.del({ "x", "o" }, "x")
            vim.keymap.del({ "x", "o" }, "X")
        end,
    },
        -- easily jump to any location and enhanced f/t motions for Leap
    {
        "ggandor/flit.nvim",
        event="VeryLazy",
        keys = function()
            ---@type LazyKeys[]
            local ret = {}
            for _, key in ipairs({ "f", "F","T","t" }) do
                ret[#ret + 1] = { key, mode = { "n", "x", "o" }  }
            end
            return ret
        end,
        opts = { labeled_modes = "nx" },
    },
}
