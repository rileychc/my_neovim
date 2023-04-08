-- This file is automatically loaded by lazyvim.plugins.config

local Util = require("util")

local function map(mode, lhs, rhs, opts)
    local keys = require("lazy.core.handler").handlers.keys
    ---@cast keys LazyKeysHandler
    -- do not create the keymap if a lazy keys handler exists
    if not keys.active[keys.parse({ lhs, mode = mode }).id] then
        opts = opts or {}
        opts.silent = opts.silent ~= false
        vim.keymap.set(mode, lhs, rhs, opts)
    end
end

--paste over  currently selected text without yanking it
map("v","p",'"_dP',{silent=true})

-- better up/down
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<A-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<A-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<A-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<A-l>", "<C-w>l", { desc = "Go to right window" })

-- 调整分屏窗口大小
map("n", "<A-'>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<A-;>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<A-[>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<A-]>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move Lines
--移动行
map("v", "<C-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<C-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

map({ "n", "v", "o" }, "<S-j>", "5j")
map({ "n", "v", "o" }, "<S-k>", "5k")
map({ "n", "v", "o" }, "<S-h>", "5h")
map({ "n", "v", "o" }, "<S-l>", "5l")

map({ "n", "v", "o" }, "U", "<C-r>")
map({ "n", "v", "o" }, "e", "$")
map({ "n", "v", "o" }, "E", "^")
map({ "n", "v", "o" }, "<A-c>", "y")
map({ "n", "v", "o" }, "<A-v>", "p")


map("n", "<A-1>", "<cmd>BufferLineGoToBuffer 1<CR>") --切换文件
map("n", "<A-2>", "<cmd>BufferLineGoToBuffer 2<CR>")
map("n", "<A-3>", "<cmd>BufferLineGoToBuffer 3<CR>")
map("n", "<A-4>", "<cmd>BufferLineGoToBuffer 4<CR>")
map("n", "<A-5>", "<cmd>BufferLineGoToBuffer 5<CR>")
map("n", "<A-6>", "<cmd>BufferLineGoToBuffer 6<CR>")
map("n", "<A-7>", "<cmd>BufferLineGoToBuffer 7<CR>")
map("n", "<A-8>", "<cmd>BufferLineGoToBuffer 8<CR>")
map("n", "<A-9>", "<cmd>BufferLineGoToBuffer 9<CR>")
map('n', '<leader>cc', ':<C-u>execute "normal!" v:count1 . "gcc"<CR>', { noremap = true })
map('x', '<leader>cc', ':<C-u>lua vim.api.nvim_command("CommentToggle")<CR>', { noremap = true })

-- -- buffers
if Util.has("bufferline.nvim") then
    map("n", "<A-{>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
    map("n", "<A-}>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
else
    map("n", "<A-{>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
    map("n", "<A-}>", "<cmd>bnext<cr>", { desc = "Next buffer" })
end


map("n", "<leader>bs", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
    "n",
    "<leader>ur",
    "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
    { desc = "Redraw / clear hlsearch / diff update" }
)

map({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- save file
map({ "i", "v", "n", "s" }, "<A-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- better indenting(缩进)
map("v", "<", "<gv")
map("v", ">", ">gv")

-- lazy
map("n", "<leader>Lz", "<cmd>:Lazy<cr>", { desc = "Lazy" })

-- new file
map("n", "<A-n>", "<cmd>enew<cr>", { desc = "New File" })

map("n", "<leader>xl", "<cmd>TodoLocList<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>TodoQuickFix<cr>", { desc = "Quickfix List" })

if not Util.has("trouble.nvim") then
    map("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
    map("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })
end

-- stylua: ignore start

-- toggle options
map("n", "<leader>uf", require("plugins.lsp.format").toggle, { desc = "Toggle format on Save" })
map("n", "<leader>us", function() Util.toggle("spell") end, { desc = "Toggle Spelling" })
map("n", "<leader>uw", function() Util.toggle("wrap") end, { desc = "Toggle Word Wrap" })
map("n", "<leader>ul", function()
    Util.toggle("relativenumber", true)
    Util.toggle("number")
end, { desc = "Toggle Line Numbers" })
map("n", "<leader>ud", Util.toggle_diagnostics, { desc = "Toggle Diagnostics" })

local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
map("n", "<leader>uc", function() Util.toggle("conceallevel", false, { 0, conceallevel }) end,
    { desc = "Toggle Conceal" })
-- lazygit
map("n", "<leader>gg", function() Util.float_term({ "lazygit" }, { cwd = Util.get_root() }) end,
    { desc = "Lazygit (root dir)" })
map("n", "<leader>gG", function() Util.float_term({ "lazygit" }) end, { desc = "Lazygit (cwd)" })

-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- highlights under cursor
if vim.fn.has("nvim-0.9.0") == 1 then
    map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
end

-- floating terminal
map("n", "<A-|>", function() Util.float_term(nil, { cwd = Util.get_root() }) end, { desc = "Terminal (root dir)" })
map("n", "<A-\\>", function() Util.float_term() end, { desc = "Terminal (cwd)" })
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })

-- windows
map("n", "<leader>ws", "<C-W>p", { desc = "Other window" })
map("n", "<A-q>", "<C-W>c", { desc = "Delete window" })
map("n", "<leader>-", "<C-W>s", { desc = "Split window below" })
map("n", "<leader>|", "<C-W>v", { desc = "Split window right" })

-- tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

--一键运行c/cpp
vim.api.nvim_create_autocmd("FileType", {
    pattern = "c",
    callback = function()
        -- -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG
        vim.api.nvim_buf_set_keymap(
            0,
            "n",
            "<A-S-r>",
            "<ESC>:w<CR>:split<CR>:te g++ -std=gcc17 -Wshadow -Wall  % -g -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG && time <CR>i",
            { silent = true, noremap = true }
        )
    end,
    pattern = "cpp",
    callback = function()
        -- -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG
        vim.api.nvim_buf_set_keymap(
            0,
            "n",
            "<A-S-r>",
            "<ESC>:w<CR>:split<CR>:te g++ -std=c++17 -Wshadow -Wall  % -g -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG && time <CR>i",
            { silent = true, noremap = true }
        )
    end,
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "c",
    callback = function()
        -- -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG
        vim.api.nvim_buf_set_keymap(
            0,
            "n",
            "<A-r>",
            "<ESC>:w<CR>:split<CR>:te g++ -std=gcc17 -Wshadow -Wall -o a.out % -g -I../include/ -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG && time ./a.out<CR>i", --%:t:r
            { silent = true, noremap = true }
        )
    end,
    pattern = "cpp",
    callback = function()
        -- -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG
        vim.api.nvim_buf_set_keymap(
            0,
            "n",
            "<A-r>",
            "<ESC>:w<CR>:split<CR>:te g++ -std=c++17 -Wshadow -Wall -o a.out % -g -I../include/ -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG && time ./a.out<CR>i\n",
            { silent = true, noremap = true }
        )
    end,
})
