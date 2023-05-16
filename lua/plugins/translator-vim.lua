return
{
    {
        "voldikss/vim-translator",
        event="VeryLazy",
        -- cmd = "",
        config = function()
            vim.cmd [[
            let g:translator_default_engines = ['youdao', 'bing','google']
          ]]
        end,
    }
}
