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

--我添加
map("i", "jk", "<Esc>")
map({ "n", "v", "o" }, "<S-j>", "5j")
map({ "n", "v", "o" }, "<S-k>", "5k")
map({ "n", "v", "o" }, "<S-h>", "5h")
map({ "n", "v", "o" }, "<S-l>", "5l")
map({ "n", "v", "o" }, "U", "<C-r>")
map({ "n", "v", "o" }, "e", "$", { desc = "End of Line" })
map({ "n", "v", "o" }, "E", "^", { desc = "Begin of Line" })
map({ "n", "v", "o" }, "<C-c>", "y")
map({ "n", "v", "o" }, "<C-v>", "p")
map({ "n", "v", "o" }, "<C-z>", "u")
map({ "n", "v", "o" }, "<C-Z>", "<C-r>")
map({ "n", "v", "o" }, "<M-F>", "<C-f>")
 map({ "n", "v", "o" }, "<M-B>", "<C-b>")
--结束

--paste over  currently selected text without yanking it
map("v", "p", '"_dP', { silent = true })
-- better up/down
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- Move to window using the <ctrl> hjkl keys
map("n", "<leader>h", "<C-w>h", { desc = "Go to left window" })
map("n", "<leader>j", "<C-w>j", { desc = "Go to lower window" })
map("n", "<leader>k", "<C-w>k", { desc = "Go to upper window" })
map("n", "<leader>l", "<C-w>l", { desc = "Go to right window" })
-- 调整分屏窗口大小
map("n", "<C-'>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-;>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-[>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-]>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
--移动行
map("n", "<C-J>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<C-K>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("v" , "<C-J>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v" , "<C-K>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

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
-- save file
map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
-- better indenting(缩进)     n模式下可使用>>锁进单行
map("v", "<", "<gv")
map("v", ">", ">gv")
-- new file
map("n", "<C-n>", "<cmd>enew<cr>", { desc = "New File" })
map("n", "<leader>xl", "<cmd>TodoLocList<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>TodoQuickFix<cr>", { desc = "Quickfix List" })
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
map("n", "<C-|>", function() Util.float_term(nil, { cwd = Util.get_root() }) end, { desc = "Terminal (root dir)" })
map("n", "<C-\\>", function() Util.float_term() end, { desc = "Terminal (cwd)" })
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
-- windows
-- map("n", "<leader>ws", "<C-W>p", { desc = "Other window" })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete window" })
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
            "<C-S-r>",
            "<ESC>:w<CR>:split<CR>:te g++ -std=gcc17 -Wshadow -Wall -o ~/Public/Bin_Files/a.out % -g -I ./include/ -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG && time <CR>i",
            { silent = true, noremap = true }
        )
    end,
    pattern = "cpp",
    callback = function()
        -- -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG
        vim.api.nvim_buf_set_keymap(
            0,
            "n",
            "<C-S-r>",
            "<ESC>:w<CR>:split<CR>:te g++ -std=c++17 -Wshadow -Wall -o ~/Public/Bin_Files/a.out  % -g -I ./include/ -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG && time <CR>i", --./src/*.cpp
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
            "<C-r>",
            "<ESC>:w<CR>:split<CR>:te g++ -std=gcc17 -Wshadow -Wall -o ~/Public/Bin_Files/a.out % -g -I ./include/   -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG && time ~/Public/Bin_Files//a.out<CR>i", --%:t:r
            { silent = true, noremap = true }
        )
    end,
    pattern = "cpp",
    callback = function()
        -- -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG
        vim.api.nvim_buf_set_keymap(
            0,
            "n",
            "<C-r>",
            "<ESC>:w<CR>:split<CR>:te g++ -std=c++17 -Wshadow -Wall -o ~/Public/Bin_Files/a.out %  -g -I ./include/   -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG && time ~/Public/Bin_Files/a.out<CR>i\n", --
            { silent = true, noremap = true }
        )
    end,
})
if not Util.has("trouble.nvim") then
    map("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
    map("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })
end
-- -- buffers
if Util.has("bufferline.nvim") then
    map("n", "<C-{>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
    map("n", "<C-}>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" }) --<C-{>
    map("n", "<C-1>", "<cmd>BufferLineGoToBuffer 1<CR>")                        --切换文件
    map("n", "<C-2>", "<cmd>BufferLineGoToBuffer 2<CR>")
    map("n", "<C-3>", "<cmd>BufferLineGoToBuffer 3<CR>")
    map("n", "<C-4>", "<cmd>BufferLineGoToBuffer 4<CR>")
    map("n", "<C-5>", "<cmd>BufferLineGoToBuffer 5<CR>")
    map("n", "<C-6>", "<cmd>BufferLineGoToBuffer 6<CR>")
    map("n", "<C-7>", "<cmd>BufferLineGoToBuffer 7<CR>")
    map("n", "<C-8>", "<cmd>BufferLineGoToBuffer 8<CR>")
    map("n", "<C-9>", "<cmd>BufferLineGoToBuffer 9<CR>")
else
    map("n", "<C-{>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
    map("n", "<C-}>", "<cmd>bnext<cr>", { desc = "Next buffer" })
end