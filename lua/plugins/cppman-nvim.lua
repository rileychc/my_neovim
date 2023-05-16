return
{
    {
        "madskjeldgaard/cppman.nvim",
        event = "VeryLazy",
        dependencies = {
            { 'MunifTanjim/nui.nvim' ,event = "VeryLazy",},
        },
        config = function()
            require("cppman").setup()
        end,
    }
}
