return {
    -- cmdline tools and lsp servers
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        opts = {
            ensure_installed = {
                "stylua",  --lua
                "lua-language-server",
                "pyright", --python
                "python-lsp-server",
                "clangd",
                "codelldb",
                "cmake-language-server",
                "prettierd",  --代码格式化
                "flake8",     --python
                "shellcheck", --shell
                "shfmt",      --shell
            },
        },
        ---@param opts MasonSettings | {ensure_installed: string[]}
        config = function(_, opts)
            require("mason").setup(opts)
            local mr = require("mason-registry")
            local function ensure_installed()
                for _, tool in ipairs(opts.ensure_installed) do
                    local p = mr.get_package(tool)
                    if not p:is_installed() then
                        p:install()
                    end
                end
            end
            if mr.refresh then
                mr.refresh(ensure_installed)
            else
                ensure_installed()
            end
        end,
    },
    {--是mason-null更好工作，可有可无
        "jay-babu/mason-null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
          "williamboman/mason.nvim",
          "jose-elias-alvarez/null-ls.nvim",
        },
        config = function()
          require("plugins.null-ls-nvim") -- require your null-ls config here (example below)
        end,
    },
    {
        "jayp0521/mason-nvim-dap.nvim", --依赖插件
        lazy = true,
        opts = { automatic_setup = true },
    },
}
