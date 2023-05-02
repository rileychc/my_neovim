local M = {}

---@type PluginLspKeys
M._keys = nil

---@return (LazyKeys|{has?:string})[]
function M.get()
    local format = require("plugins.lsp.format").format
    if not M._keys then
        ---@class PluginLspKeys
        -- stylua: ignore
        M._keys = {
            { "<leader>Lf", "<cmd>LspInfo<cr>",            desc = "Lsp Info" },
            { "gr",         "<cmd>Lspsaga lsp_finder<CR>", desc = "References", },
            {
                "<F2>",
                "<cmd>Lspsaga rename<CR>",
                desc = "Rename",
            },
            {
                "<F14>",
                "<cmd>Lspsaga rename ++project<CR>",
                desc = "Rename in project",
            },
            {
                "gd",
                "<cmd>Lspsaga peek_definition<CR>",
                desc = "Peek  Definition",
            },
            {
                "gD",
                "<cmd>Lspsaga goto_definition<CR>",
                desc = "Goto Definition",
            },
            {
                "gt",
                "<cmd>Lspsaga peek_type_definition<CR>",
                desc = "Peek Type Definition",
            },
            {
                "gT",
                "<cmd>Lspsaga goto_type_definition<CR>",
                desc = "Goto Type Definition",
            },
            {
                "gsl",
                "<cmd>Lspsaga show_line_diagnostics<CR>",
                desc = "Show line diagnostics",
            },
            {
                "gsb",
                "<cmd>Lspsaga show_buf_diagnostics<CR>",
                desc = "Show buffer diagnostics",
            },
            {
                "gsw",
                "<cmd>Lspsaga show_workspace_diagnostics<CR>",
                desc = "Show workspace diagnostics",
            },
            {
                "gsc",
                "<cmd>Lspsaga show_cursor_diagnostics<CR>",
                desc = "Show cursor diagnostics",
            },
            {
                "[g",
                "<cmd>Lspsaga diagnostic_jump_prev<CR>",
                desc = "Next Diagnostic",
            },
            {
                "]g",
                "<cmd>Lspsaga diagnostic_jump_next<CR>",
                desc = "Prev Diagnostic",
            },
            {
                "[e",
                function()
                    require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
                end,
                desc = "Prev Error"
            },
            {
                "]e",
                function()
                    require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
                end,
                desc = "Next Error"
            },
            {
                "[w",
                function()
                    require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.WARN })
                end,
                desc = "Prev Warning"
            },
            {
                "]w",
                function()
                    require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.WARN })
                end,
                desc = "Next Warning"
            },
            { "go",  "<cmd>Lspsaga outline<CR>",          desc = "Toggle outline" },
            { "gk",  "<cmd>Lspsaga hover_doc<CR>",        desc = "Hover" },
            { "gK",  "<cmd>Lspsaga hover_doc ++keep<CR>", desc = "Keep Hover" },
            { "gci", "<cmd>Lspsaga incoming_calls<CR>",   desc = "Call in hierarchy" },
            { "gco", "<cmd>Lspsaga outgoing_calls<CR>",   desc = "Call out hierarchy" },
            {
                "<C-k>",
                vim.lsp.buf.signature_help,
                mode = "i",
                desc = "Signature Help",
                has =
                "signatureHelp"
            },
            { "gF", format,                         desc = "Format Document", has = "documentFormatting" },
            {
                "gF",
                format,
                desc = "Format Range",
                mode = "v",
                has =
                "documentRangeFormatting"
            },
            { "ga", "<cmd>Lspsaga code_action<CR>", desc = "Code action",     mode = { "n", "v" } },
        }
    end
    return M._keys
end

function M.on_attach(client, buffer)
    local Keys = require("lazy.core.handler.keys")
    local keymaps = {} ---@type table<string,LazyKeys|{has?:string}>

    for _, value in ipairs(M.get()) do
        local keys = Keys.parse(value)
        if keys[2] == vim.NIL or keys[2] == false then
            keymaps[keys.id] = nil
        else
            keymaps[keys.id] = keys
        end
    end

    for _, keys in pairs(keymaps) do
        if not keys.has or client.server_capabilities[keys.has .. "Provider"] then
            local opts = Keys.opts(keys)
            ---@diagnostic disable-next-line: no-unknown
            opts.has = nil
            opts.silent = opts.silent ~= false
            opts.buffer = buffer
            vim.keymap.set(keys.mode or "n", keys[1], keys[2], opts)
        end
    end
end

function M.diagnostic_goto(next, severity)
    local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
    severity = severity and vim.diagnostic.severity[severity] or nil
    return function()
        go({ severity = severity })
    end
end

return M
