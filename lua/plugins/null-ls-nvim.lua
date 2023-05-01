return
{                                          -- 这个插件可以让你更方便地在 NeoVim 中使用 Null-ls。它提供了一些高级的配置和使用功能，可以帮助你更好地定制和优化 Null-ls 的使用。
    {
        "jose-elias-alvarez/null-ls.nvim", --代码建议/报错
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "mason.nvim" },
        lazy = true,
        opts = function()
            local M = {}

            function M.pre()
            end

            function M.post()
                local nls = require("null-ls")
                local bt = nls.builtins


                nls.setup({
                    root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
                    sources = {
                        -- require("typescript.extensions.null-ls.code-actions"),
                        -- c/c++
                        bt.formatting.clang_format,
                        bt.diagnostics.cppcheck,

                        bt.completion.spell, --再加上
                        bt.formatting.prettierd,
                        -- python
                        bt.formatting.ruff,
                        bt.diagnostics.ruff,

                        -- golang
                        bt.formatting.gofmt,
                        bt.formatting.goimports,
                        bt.diagnostics.golangci_lint,

                        -- lua
                        bt.formatting.stylua,
                        bt.diagnostics.luacheck,

                        -- javascript / css / json / yaml
                        bt.formatting.prettier,
                        bt.diagnostics.eslint,
                        bt.diagnostics.stylelint,
                        bt.diagnostics.jsonlint,
                        bt.diagnostics.yamllint,

                        -- shell
                        bt.formatting.shfmt.with({
                            extra_filetypes = { "zsh" },
                        }),
                        bt.diagnostics.shellcheck,

                        -- markdown
                        bt.diagnostics.markdownlint,

                        -- other
                        bt.diagnostics.cspell.with({
                            extra_args = { "--config", vim.fn.expand("~/.config/nvim/neo-cspell.yaml") },
                            diagnostics_postprocess = function(diagnostic)
                                diagnostic.severity = vim.diagnostic.severity.HINT
                            end,
                            require("typescript.extensions.null-ls.code-actions"),
                        }),

                        bt.formatting.fish_indent,
                        bt.diagnostics.fish,


                        -- nls.builtins.formatting.shfmt,
                        -- nls.builtins.diagnostics.flake8,
                    },
                    should_attach = function(bufnr)
                        local file_type = vim.api.nvim_buf_get_option(bufnr, "filetype")
                        if vim.tbl_contains({ "NvimTree" }, file_type) then
                            return false
                        end

                        local buftype = vim.api.nvim_buf_get_option(bufnr, "buftype")
                        if buftype ~= "" then
                            return false
                        end

                        return true
                    end,
                })

                -- disable all diagnostics capacity at init
                nls.disable({ method = nls.methods.DIAGNOSTICS })
            end

            function M.keybind()
            end

            return M
        end,
    },
}
