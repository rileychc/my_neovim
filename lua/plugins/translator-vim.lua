return
{
    {
        "voldikss/vim-translator",
        -- cmd = "",
        keys = {
            { "<leader>t",  "<cmd>Translate<cr>",  desc = "Translate",         mode = { "n", "v" } },
            { "<leader>tr", "<cmd>TranslateR<cr>", desc = "Translate Replace", mode = { "n", "v" } },
        },
        config = function()
            vim.cmd [[
            let g:translator_default_engines = ['youdao', 'bing','google']
          ]]
        end,
    }
}
