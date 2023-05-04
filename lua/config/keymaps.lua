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
map("n", "<leader>Lz", "<cmd>Lazy<cr>", { desc = "Lazy" })
map("n", "<leader>Lm", "<cmd>Mason<cr>", { desc = "Mason" })
map("i", "jk", "<Esc>")
map({ "n", "v", "o" }, "<S-j>", "5j")
map({ "n", "v", "o" }, "<S-k>", "5k")
map({ "n", "v", "o" }, "<S-h>", "5h")
map({ "n", "v", "o" }, "<S-l>", "5l")
map({ "n", "v", "o" }, "U", "<C-r>")
map({ "n", "v", "o" }, "e", "$", { desc = "End of Line" })
map({ "n", "v", "o" }, "E", "^", { desc = "Begin of Line" })
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
map("n", "<A-'>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<A-;>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<A-[>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<A-]>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
--移动行
map("n", "<A-J>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-K>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("v", "<A-J>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-K>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map("n", "<leader>ur", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
    { desc = "Redraw / clear hlsearch / diff update" })
map({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
-- save file
map({ "i", "v", "n", "s" }, "<A-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
-- better indenting(缩进)     n模式下可使用>>锁进单行
map("v", "<", "<gv")
map("v", ">", ">gv")
-- new file
map("n", "<A-n>", "<cmd>enew<cr>", { desc = "New File" })
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
-- floating terminal
map("n", "<A-|>", function() Util.float_term(nil, { cwd = Util.get_root() }) end, { desc = "Terminal (root dir)" })
map("n", "<A-\\>", function() Util.float_term() end, { desc = "Terminal (cwd)" })
map("t", "<esc><esc>", "<C-\\><C-n>", { desc = "Enter Normal Mode" })
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

if Util.has("mini.bufremove") then
    map("n", "<leader>bd", function() require("mini.bufremove").delete(0, false) end, { desc = "Delete Buffer" })
    map("n", "<leader>bD", function() require("mini.bufremove").delete(0, true) end, { desc = "Delete Buffer(Force)" })
end
-- -- buffers
if Util.has("bufferline.nvim") then
    map("n", "<A-{>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
    map("n", "<A-}>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" }) --<A-{>
    map("n", "<A-1>", "<cmd>BufferLineGoToBuffer 1<CR>")                        --切换文件
    map("n", "<A-2>", "<cmd>BufferLineGoToBuffer 2<CR>")
    map("n", "<A-3>", "<cmd>BufferLineGoToBuffer 3<CR>")
    map("n", "<A-4>", "<cmd>BufferLineGoToBuffer 4<CR>")
    map("n", "<A-5>", "<cmd>BufferLineGoToBuffer 5<CR>")
    map("n", "<A-6>", "<cmd>BufferLineGoToBuffer 6<CR>")
    map("n", "<A-7>", "<cmd>BufferLineGoToBuffer 7<CR>")
    map("n", "<A-8>", "<cmd>BufferLineGoToBuffer 8<CR>")
    map("n", "<A-9>", "<cmd>BufferLineGoToBuffer 9<CR>")
end

if Util.has("noice.nvim") then
    map("c", "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, { desc = "Redirect Cmdline" })
    map("n", "<leader>nl", function() require("noice").cmd("last") end, { desc = "Noice Last Message" })
    map("n", "<leader>nh", function() require("noice").cmd("history") end, { desc = "Noice History" })
    map("n", "<leader>na", function() require("noice").cmd("all") end, { desc = "Noice All" })
    map({ "n", "i", "s" }, "<A-f>", function() if not require("noice.lsp").scroll(4) then return "<C-f>" end end,
        { silent = true, desc = "Scroll forward" })
    map({ "n", "i", "s" }, "<A-b>", function() if not require("noice.lsp").scroll(-4) then return "<C-b>" end end,
        { silent = true, desc = "Scroll backward" })
end
--chatgpt
if Util.has("ChatGPT.nvim") then
    map("n", "<leader>cg", "<cmd>ChatGPT<CR>", { desc = "ChatGPT" })
    map("n", "<leader>ca", "<cmd>ChatGPTActAs<CR>", { desc = "ChatGPT As" })
    map("n", "<leader>ce", "<cmd>ChatGPTEditWithInstructions<CR>", { desc = "ChatGPT Editor" })
end
--cppman
if Util.has("cppman.nvim") then
    map("n", "<leader>cw", function() require("cppman").open_cppman_for(vim.fn.expand("<cword>")) end,
        { desc = "CurWordHelp" })
    map("n", "<leader>ch", "<cmd>CPPMan<CR>", { desc = "FindLibraryHelp" })
end

if Util.has("trouble.nvim") then
    map("n", "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", { desc = "Document Diagnostics (Trouble)" })
    map("n", "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", { desc = "Workspace Diagnostics (Trouble)" })
    map("n", "<leader>xL", "<cmd>TroubleToggle loclist<cr>", { desc = "Location List (Trouble)" })
    map("n", "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", { desc = "Quickfix List (Trouble)" })
    map("n",
        "[q",
        function()
            if require("trouble").is_open() then
                require("trouble").previous({ skip_groups = true, jump = true })
            else
                vim.cmd.cprev()
            end
        end,
        { desc = "Previous trouble/quickfix item" })
    map("n",
        "]q",
        function()
            if require("trouble").is_open() then
                require("trouble").next({ skip_groups = true, jump = true })
            else
                vim.cmd.cnext()
            end
        end,
        { desc = "Next trouble/quickfix item" }
    )
end
if Util.has("markdown-preview.nvim") then
    map("n", "<leader>md", "<cmd>MarkdownPreviewToggle<CR>", { desc = "MarkdownPreviewToggle" })
end
--FIX:
-- if Util.has("clipboard-image.nvim") then
--     map("n", "<leader>mi", "<cmd>PasteImg<CR>", { desc = "PasteImg" })
-- end

if Util.has("vim-translator") then
    map({ "n", "v" }, "<leader>tt", "<cmd>Translate<cr>", { desc = "Translate" })
    map({ "n", "v" }, "<leader>tr", "<cmd>TranslateR<cr>", { desc = "Translate Replace" })
end
if Util.has("todo-comments.nvim") then
    map("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next todo comment" })
    map("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "Previous todo comment" })
    map("n", "<leader>xt", "<cmd>TodoTrouble<cr>", { desc = "Todo (Trouble)" })
    map("n", "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", { desc = "Todo/Fix/Fixme (Trouble)" })
    map("n", "<leader>st", "<cmd>TodoTelescope<cr>", { desc = "Todo" })
end


if Util.has("persistent-breakpoints.nvim") then
    map("n", "<2-LeftMouse>", "<cmd>PBToggleBreakpoint<CR>", { desc = "Toggle BreakPoint" })
    map("n", "<F9>", "<cmd>PBToggleBreakpoint<CR>", { desc = "Toggle BreakPoint" })
    map("n", "<leader>dc", "<cmd>PBClearAllBreakpoints<CR>", { desc = "Clear BreakPoint" })
    map("n", "<leader>dB", "<cmd>PBSetConditionalBreakpoint<CR>", { desc = "Condition BreakPoint" })
end

if Util.has("nvim-dap") then
    map("n", "<F17>", "<cmd>DapTerminate<CR>", { desc = "Quit Debug" })
    map("n", "<F41>", "<cmd>DapRestartFrame<CR>", { desc = "Restart Debug" }) --重新开始
    map("n", "<F5>", "<cmd>DapContinue<CR>", { desc = "Start Debug" })        --开始或继续
    map("n", "<F23>", "<cmd>DapStepOut<CR>", { desc = "Step Out" })           --跳出
    map("n", "<F10>", "<cmd>DapStepOver<CR>", { desc = "Step Over" })
    map("n", "<F11>", "<cmd>DapStepInto<CR>", { desc = "Step Into" })
end

if Util.has("neo-tree.nvim") then
    map("n", "<leader>e", function()
        require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
    end, { desc = "Explorer NeoTree (cwd)" })
    map("n", "<leader>E", function()
        require("neo-tree.command").execute({ toggle = true, dir = require("util").get_root() })
    end, { desc = "Explorer NeoTree (root dir)" })
end
if Util.has("persistence.nvim") then
    map("n", "<leader>qs", function() require("persistence").load() end, { desc = "Restore Session" })
    map("n", "<leader>ql", function() require("persistence").load({ last = true }) end, { desc = "Restore Last Session" })
    map("n", "<leader>qd", function() require("persistence").stop() end, { desc = "Don't Save Current Session" })
end
if Util.has("nvim-notify") then
    map("n", "<leader>nc", function()
        require("notify").dismiss({ silent = true, pending = true })
    end, { desc = "Delete All Notifications" })
end
--
if Util.has("telescope.nvim") then
    --   map( "n", --在插件中查找
    --     "<leader>fp",
    --     function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
    --     {desc = "Find Plugin File"})
    -- --加上
    map("n", "<leader><", "<cmd>Telescope buffers show_all_buffers=true<cr>", { desc = "All Buffer" }) --显示所有缓冲区
    map("n", "<leader>?", Util.telescope("live_grep"), { desc = "Find in Files (root dir)" })
    map("n", "<leader>/", Util.telescope("live_grep", { cwd = false }), { desc = "Find in Files (cwd)" })
    map("n", "<leader>sW", Util.telescope("grep_string"), { desc = "Word (root dir)" })
    map("n", "<leader>sw", Util.telescope("grep_string", { cwd = false }), { desc = "Word (cwd)" })
    map("n", "<leader>;", "<cmd>Telescope command_history<cr>", { desc = "Command History" }) --查询历史命令
    map("n", "<leader>:", "<cmd>Telescope commands<cr>", { desc = "Commands" })
    -- find
    map("n", "<leader>,", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })             --显示当前缓冲区
    map("n", "<leader>>", Util.telescope("files"), { desc = "Find Files (root dir)" })    --全局查找
    map("n", "<leader>.", Util.telescope("files", { cwd = false }), { desc = "Find Files (cwd)" })
    map("n", "<leader><space>", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" }) --查找最近文件
    -- -- git
    map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "commits" })
    map("n", "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "status" })
    -- search
    map("n", "<leader>sa", "<cmd>Telescope autocommands<cr>", { desc = "Auto Commands" })
    map("n", "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Buffer" })
    map("n", "<leader>sd", "<cmd>Telescope diagnostics<cr>", { desc = "Diagnostics" })
    map("n", "<leader>sg", Util.telescope("live_grep"), { desc = "Grep (root dir)" })
    map("n", "<leader>sG", Util.telescope("live_grep", { cwd = false }), { desc = "Grep (cwd)" })
    map("n", "<leader>sh", "<cmd>Telescope help_tags<cr>", { desc = "Help Pages" })
    map("n", "<leader>sH", "<cmd>Telescope highlights<cr>", { desc = "Search Highlight Groups" })
    map("n", "<leader>sk", "<cmd>Telescope keymaps<cr>", { desc = "Key Maps" })
    map("n", "<leader>sM", "<cmd>Telescope man_pages<cr>", { desc = "Man Pages" })
    map("n", "<leader>sm", "<cmd>Telescope marks<cr>", { desc = "Jump to Mark" })
    map("n", "<leader>so", "<cmd>Telescope vim_options<cr>", { desc = "Options" })
    map("n", "<leader>sR", "<cmd>Telescope resume<cr>", { desc = "Resume" })
    map("n", "<leader>uC", Util.telescope("colorscheme", { enable_preview = true }),
        { desc = "Colorscheme with preview" })
    map("n",
        "<leader>ss",
        Util.telescope("lsp_document_symbols",
            {
                symbols = { "Class", "Function", "Method", "Constructor", "Interface", "Module", "Struct", "Trait",
                    "Field", "Property", },
            }), { desc = "Goto Symbol" })
    map("n", "<leader>sS",
        Util.telescope("lsp_workspace_symbols", {
            symbols = { "Class", "Function", "Method", "Constructor", "Interface", "Module", "Struct", "Trait", "Field",
                "Property", },
        }), { desc = "Goto Symbol (Workspace)", })
end
-- highlights under cursor
if vim.fn.has("nvim-0.9.0") == 1 then
    map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
end

--cmp-nvim
--treesitter.nvim
--gitsigns-nvim
--leap.nvim
--mini-comment
--mini-surround
--lsp/keymaps
--telescope-nvim

--一键编译c/cpp
vim.api.nvim_create_autocmd("FileType", {
    pattern = "c",
    callback = function()
        -- -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG
        vim.api.nvim_buf_set_keymap(0, "n", "<A-S-r>",
            "<ESC>:w<CR>:split<CR>:te gcc -std=c17 -Wshadow -Wall -o ~/Public/Bin_Files/a.out % -g -I ./include/ -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG && time <CR>i",
            { silent = true, noremap = true })
    end,
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "cpp",
    callback = function()
        -- -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG
        vim.api.nvim_buf_set_keymap(0, "n", "<A-S-r>",
            "<ESC>:w<CR>:split<CR>:te g++ -std=c++17 -Wshadow -Wall -o ~/Public/Bin_Files/a.out  % -g -I ./include/ -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG && time <CR>i",
            { silent = true, noremap = true })
    end,
}) --./src/*.cpp

--一键运行代码文件
--C
vim.api.nvim_create_autocmd("FileType", {
    pattern = "c",
    callback = function()
        -- -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG
        vim.api.nvim_buf_set_keymap(0, "n", "<A-r>",
            "<ESC>:w<CR>:split<CR>:te gcc  -std=c17 -Wshadow -Wall -o ~/Public/Bin_Files/a.out % -g -I ./include/   -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG && time ~/Public/Bin_Files//a.out<CR>i", --%:t:r
            { silent = true, noremap = true }
        )
    end,
})
--C++
vim.api.nvim_create_autocmd("FileType", {
    pattern = "cpp",
    callback = function()
        -- -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG
        vim.api.nvim_buf_set_keymap(
            0,
            "n",
            "<A-r>",
            "<ESC>:w<CR>:split<CR>:te g++ -std=c++17 -Wshadow -Wall -o ~/Public/Bin_Files/a.out %  -g -I ./include/   -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG && time ~/Public/Bin_Files/a.out<CR>i\n", --
            { silent = true, noremap = true }
        )
    end,
})
--Python
vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", "<A-r>",

            ":w<CR>:split<CR>:te  time python3 % <CR>i",
            { silent = true, noremap = true }
        )
    end,

})
--Java
vim.api.nvim_create_autocmd("FileType", {
    pattern = "java",
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", "<A-r>",

            ":w<CR>:split<CR>:te  time java % <CR>i",
            { silent = true, noremap = true }
        )
    end,

})
