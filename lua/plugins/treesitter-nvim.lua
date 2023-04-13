return {
    {
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
            -- highlight = {
            --     enable = true,
            --     disable = function(ft, bufnr)
            --         if vim.tbl_contains({ "vim" }, ft) then
            --             return true
            --         end
    
            --         local ok, is_large_file = pcall(vim.api.nvim_buf_get_var, bufnr, "bigfile_disable_treesitter")
            --         return ok and is_large_file
            --     end,
            --     additional_vim_regex_highlighting = { "c", "cpp" },
            -- },

            -- textobjects = {  --我加上
            --     select = {
            --         enable = true,
            --         keymaps = {
            --             ["af"] = "@function.outer",
            --             ["if"] = "@function.inner",
            --             ["ac"] = "@class.outer",
            --             ["ic"] = "@class.inner",
            --         },
            --     },
            --     move = {
            --         enable = true,
            --         set_jumps = true, -- whether to set jumps in the jumplist
            --         goto_next_start = {
            --             ["]["] = "@function.outer",
            --             ["]m"] = "@class.outer",
            --         },
            --         goto_next_end = {
            --             ["]]"] = "@function.outer",
            --             ["]M"] = "@class.outer",
            --         },
            --         goto_previous_start = {
            --             ["[["] = "@function.outer",
            --             ["[m"] = "@class.outer",
            --         },
            --         goto_previous_end = {
            --             ["[]"] = "@function.outer",
            --             ["[M"] = "@class.outer",
            --         },
            --     },
            -- },
            -- rainbow = {
            --     enable = true,
            --     extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
            --     max_file_lines = 2000, -- Do not enable for files with more than 2000 lines, int
            -- },
            -- matchup = { enable = true },
--结束
            
            indent = { enable = true },
            context_commentstring = { enable = true, enable_autocmd = false },
            ensure_installed = {
                "bash",
                "c",
                "cpp",
                "vimdoc",
                "html",
                "javascript",
                "json",
                "jsonc",
                "json5",
                "lua",
                "luadoc",
                "luap",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "regex",
                "tsx",
                "typescript",
                "vim",
                "yaml",
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

