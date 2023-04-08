-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config").setup(opts)
vim.g.python3_host_prog = '/opt/homebrew/bin/python3'
