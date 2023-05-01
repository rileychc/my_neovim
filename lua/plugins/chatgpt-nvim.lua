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
        keys=
        {
{"<leader>cg","<cmd>ChatGPT<CR>",desc="ChatGPT",mode="n"},
{"<leader>ca","<cmd>ChatGPTActAs<CR>",desc="ChatGPT As",mode="n"},
{"<leader>ce","<cmd>ChatGPTEditWithInstructions<CR>",desc="ChatGPT Editor",mode="n"}
        },
        config = function()
            require("chatgpt").setup()
        end,
    }, 
}
