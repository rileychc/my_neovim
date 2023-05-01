require("config").init()
return {
    { "folke/lazy.nvim", version = "*" ,

},
    --测量启动时间
    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
        keys={
            { "<leader>Lz", "<cmd>:Lazy<cr>",  desc = "Lazy" ,mode="n"}
        },
        config = function()
            vim.g.startuptime_tries = 10
        end,
    },

}
