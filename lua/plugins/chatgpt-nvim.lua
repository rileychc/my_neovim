return
{
    {
        "jackMort/ChatGPT.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        },
        run = 'pip3 install -r requirements.txt',
        config = function()
            require("chatgpt").setup()
        end,
    }, 
}
