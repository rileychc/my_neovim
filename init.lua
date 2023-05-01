-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config").setup(opts)

vim.g.python3_host_prog = '/opt/homebrew/bin/python3'
vim.g.loaded_perl_provider = 0
vim.g.lazy_nvim_update_on_save = 0
 