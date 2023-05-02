
return
{

    {
        "madskjeldgaard/cppman.nvim",
        event = "VeryLazy",
        dependencies = {
            { 'MunifTanjim/nui.nvim' },
        },
        config = function()
        require("cppman").setup()
        end,
    }
}
