return {
    {
                         --这个插件可以让你更方便地在 NeoVim 中使用 Treesitter。它提供了一些高级的功能，可以帮助你更好地理解和编辑代码。
        "nvim-treesitter/nvim-treesitter",
        version = false, -- last release is way too old and doesn't work on Windows
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter-textobjects",
                init = function()
                    -- PERF: no need to load the plugin, if we only need its queries for mini.ai
                    local plugin = require("lazy.core.config").spec.plugins["nvim-treesitter"]
                    local opts = require("lazy.core.plugin").values(plugin, "opts", false)
                    local enabled = false
                    if opts.textobjects then
                        for _, mod in ipairs({ "move", "select", "swap", "lsp_interop" }) do
                            if opts.textobjects[mod] and opts.textobjects[mod].enable then
                                enabled = true
                                break
                            end
                        end
                    end
                    if not enabled then
                        require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
                    end
                end,
            },
        },
        keys = {
            { "<A-space>", desc = "Increment selection" },
            { "<bs>",      desc = "Decrement selection", mode = "x" },
        },
        ---@type TSConfig
        opts = {
            highlight = { enable = true },
            indent = { enable = true },
            context_commentstring = { enable = true, enable_autocmd = false },
            ensure_installed = {
                "c",
                "cpp",
                "vim",
                "lua",
                "luadoc",
                "luap",
                "markdown",
                "markdown_inline",
                "python",
                "query", --SQL
                "regex", --正则
                "jsonc",
                "bash",
                "vimdoc",
                -- "html",
                -- "javascript",
                -- "json",
                -- "json5",
                -- "tsx",
                -- "typescript",
                -- "yaml",
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<A-space>",
                    node_incremental = "<A-space>",
                    scope_incremental = "<nop>",
                    node_decremental = "<bs>",
                },
            },
        },
        ---@param opts TSConfig
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
            vim.api.nvim_set_option_value("foldmethod", "expr", {})
            vim.api.nvim_set_option_value("foldexpr", "nvim_treesitter#foldexpr()", {})
            vim.api.nvim_set_option_value("foldenable", false, {})
        end,
    },
}
