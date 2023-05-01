return {

    {

        "iamcco/markdown-preview.nvim",
        lazy = true,
        -- 需要调整nodejs版本
        build = "source /usr/share/nvm/init-nvm.sh; nvm use v18; cd app && npm install",
        ft = { "markdown" },
        keys = {
            { "<leader>md", "<cmd>MarkdownPreviewToggle<cr>", desc = "MarkdownPreviewToggle" },
        },
        config = function()
            -- vim.cmd([[let g:mkdp_auto_start = 1]]) --这是格式
            vim.g.mkdp_theme='light'
            vim.g.mkdp_auto_start=1
            vim.g.mkdp_auto_close=0
            vim.g.mkdp_markdown_css="/Users/riley/.config/node_modules/github-markdown-css/github-markdown.css"
            vim.g.mkdp_highlight_css="/Users/riley/.config/node_modules/github-markdown-css/github-markdown.css"
        end,
    },
    {
        "ekickx/clipboard-image.nvim", --markdown插入图片
        lazy = true,
        config = function()
            require 'clipboard-image'.setup {
                -- Default configuration for all filetype
                default = {
                    img_dir = "./img",
                    img_name = function() return os.date('%Y-%m-%d-%H-%M-%S') end, -- Example result: "2021-04-13-10-04-18"
                    affix = "<\n  %s\n>"                                           -- Multi lines affix
                },
                -- You can create configuration for ceartain filetype by creating another field (markdown, in this case)
                -- If you're uncertain what to name your field to, you can run `lua print(vim.bo.filetype)`
                -- Missing options from `markdown` field will be replaced by options from `default` field
                markdown = {
                    img_dir = { "./img", "src", "assets", "img" }, -- Use table for nested dir (New feature form PR #20)
                    img_dir_txt = "./img/src/assets/img",
                    img_handler = function(img)                    -- New feature from PR #22
                        local script = string.format('./image_compressor.sh "%s"', img.path)
                        os.execute(script)
                    end,
                }
            }
        end,
        keys = {
            { "<leader>mi", "<cmd>PasteImg<cr>", desc = "PasteImg" },

        },
    }
}
