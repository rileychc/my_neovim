return {
    -- 浮动通知窗口
    {
        "rcarriga/nvim-notify",
        lazy = true,
        -- event = "VeryLazy",
        opts = {
            background_colour = "#000000",
            timeout = 3000,
            max_height = function()
                return math.floor(vim.o.lines * 0.3)
            end,
            max_width = function()
                return math.floor(vim.o.columns * 0.3)
            end,
            --我修改
            render = "minimal",
        },
        init = function()
            require("telescope").load_extension("notify") --加载
            -- when noice is not enabled, install notify on VeryLazy
            local Util = require("util")
            if not Util.has("noice.nvim") then
                Util.on_very_lazy(function()
                    vim.notify = require("notify")
                end)
            end
        end,
    },
}
