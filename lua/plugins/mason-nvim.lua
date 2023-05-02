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
}
