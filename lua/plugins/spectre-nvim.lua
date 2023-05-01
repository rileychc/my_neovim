return {
    -- 这个插件可以让你更方便地在 NeoVim 中进行查找和替换。它提供了一些高级的查找和替换功能，可以帮助你更快地定位和修改文本。
    {
        "windwp/nvim-spectre",
        -- stylua: ignore
        keys = {
            { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
        },
    },
}
