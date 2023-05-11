return
{
    {
        "madskjeldgaard/cppman.nvim",
        event = "VeryLazy",
        lazy = true,
        dependencies = {
            { 'MunifTanjim/nui.nvim' },
        },
        config = function()
            require("cppman").setup()
        end,
    }
}
