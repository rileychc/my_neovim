return
{
    {
        "voldikss/vim-translator",
        -- cmd = "",
        config = function()
            vim.cmd [[
            let g:translator_default_engines = ['youdao', 'bing','google']
          ]]
        end,
    }
}
