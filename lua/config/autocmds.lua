-- This file is automatically loaded by plugins.init

local function augroup(name)
    return vim.api.nvim_create_augroup(name, { clear = true })
end

-- 检查当文件更改时，我们是否需要重新加载
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = augroup("checktime"),
    command = "checktime",
})

--复制的时候高亮显示 
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup("highlight_yank"),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- 如果窗口调整了大小，则调整拆分大小
vim.api.nvim_create_autocmd({ "VimResized" }, {
    group = augroup("resize_splits"),
    callback = function()
        vim.cmd("tabdo wincmd =")
    end,
})

-- 打开缓冲区时转到last loc
vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup("last_loc"),
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- close some filetypes with <q>(需要找到需要什么参数)
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("close_with_q"),
    pattern = {
        "PlenaryTestPopup",
        "help",
        "lspinfo",
        "man",
        "notify",
        "qf",
        "spectre_panel",
        "startuptime",
        "tsplayground",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})

-- wrap and check for spell in text filetypes(作用不大)
-- vim.api.nvim_create_autocmd("FileType", {
--     group = augroup("wrap_spell"),
--     pattern = { "gitcommit" },
--     callback = function()
--         vim.opt_local.wrap = true
--         -- vim.opt_local.spell = true
--     end,
-- })

--不要自动评论新行(没起作用)
-- vim.api.nvim_create_autocmd("BufEnter", { pattern = "", command = "set fo-=c fo-=r fo-=o", })
