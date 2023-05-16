local use_ssh = true
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local clone_prefix = use_ssh and "git@github.com:%s.git" or "https://github.com/%s.git"
local lazy_repo = use_ssh and "git@github.com:folke/lazy.nvim.git " or "https://github.com/folke/lazy.nvim.git "
if not vim.loop.fs_stat(lazypath) then
    -- bootstrap lazy.nvim
    -- stylua: ignore
    vim.fn.system({ "git", "clone", "--filter=blob:none", lazy_repo, "--branch=stable",
        lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)


require("lazy").setup({
    concurrency = 20, --Mac
    spec = {
        { import = "plugins" },
    },
    git = {
        -- log = { "-10" }, -- show the last 10 commits
        timeout = 300,
        url_format = clone_prefix,
    },
    defaults = {
        lazy = false,
        -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
        -- have outdated releases, which may break your Neovim install.
        version = false, -- always use the latest git commit
        -- version = "*", -- try installing the latest stable version for plugins that support semver
    },
    install = { colorscheme = { "tokyonight" } },  --, "habamax","gruvbox"
    checker = { enabled = false, notify = false }, -- automatically check for plugin updates
    change_detection = { notify = false },
    performance = {
        rtp = {
            -- disable some rtp plugins
            disabled_plugins = {
                -- "gzip",
                -- "matchit",
                -- "matchparen",
                -- "netrwPlugin",
                -- "tarPlugin",
                -- "tohtml",
                -- "tutor",
                -- "zipPlugin",
                -- "ChatGPT"
            },
        },
    },
})
require("config").setup(opts)
vim.g.python3_host_prog = '/opt/homebrew/bin/python3'
vim.g.loaded_perl_provider = 0
vim.g.lazy_nvim_update_on_save = 0
vim.g.term_program = 'nvim'
