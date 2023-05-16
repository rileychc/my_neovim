local Util = require("lazy.core.util")
local M = {}
 local icons = 
{
    kind = {
        Class = "ﴯ",
        Color = "",
        Constant = "",
        Constructor = "",
        Enum = "",
        EnumMember = "",
        Event = "",
        Field = "",
        File = "",
        Folder = "",
        Function = "",
        Interface = "",
        Keyword = "",
        Method = "",
        Module = "",
        Namespace = "",
        Number = "",
        Operator = "",
        Package = "",
        Property = "ﰠ",
        Reference = "",
        Snippet = "",
        Struct = "",
        Text = "",
        TypeParameter = "",
        Unit = "",
        Value = "",
        Variable = "",
        -- ccls-specific icons.
        TypeAlias = "",
        Parameter = "",
        StaticMethod = "",
        Macro = "",
    },
    type = {
        Array = "",
        Boolean = "",
        Null = "ﳠ",
        Number = "",
        Object = "",
        String = "",
    },
    documents = {
        Default = "",
        File = "",
        Files = "",
        FileTree = "פּ",
        Import = "",
        Symlink = "",
    },
    git = {
        Add = "",
        Branch = "",
        Diff = "",
        Git = "",
        Ignore = "",
        Mod = "M",
        Mod_alt = "",
        Remove = "",
        Rename = "",
        Repo = "",
        Unmerged = "שׂ",
        Untracked = "ﲉ",
        Unstaged = "",
        Staged = "",
        Conflict = "",
    },
    ui = {
        ArrowClosed = "",
        ArrowOpen = "",
        BigCircle = "",
        BigUnfilledCircle = "",
        BookMark = "",
        Bug = "",
        Calendar = "",
        Check = "",
        ChevronRight = "",
        Circle = "",
        Close = "",
        Close_alt = "",
        CloudDownload = "",
        Comment = "",
        CodeAction = "",
        Dashboard = "",
        Emoji = "",
        EmptyFolder = "",
        EmptyFolderOpen = "",
        File = "",
        Fire = "",
        Folder = "",
        FolderOpen = "",
        Gear = "",
        History = "",
        Incoming = "",
        Indicator = "",
        Keyboard = "",
        Left = "",
        List = "",
        Square = "",
        SymlinkFolder = "",
        Lock = "",
        Modified = "✥",
        Modified_alt = "",
        NewFile = "",
        Newspaper = "",
        Note = "",
        Outgoing = "",
        Package = "",
        Pencil = "",
        Perf = "",
        Play = "",
        Project = "",
        Right = "",
        RootFolderOpened = "",
        Search = "",
        Separator = "",
        DoubleSeparator = "",
        SignIn = "",
        SignOut = "",
        Sort = "",
        Spell = "暈",
        Symlink = "",
        Table = "",
        Telescope = "",
    },
    diagnostics = {
        Error = "",
        Warning = "",
        Information = "",
        Question = "",
        Hint = "",
        -- Holo version
        Error_alt = "",
        Warning_alt = "",
        Information_alt = "",
        Question_alt = "",
        Hint_alt = "",
    },
    misc = {
        Campass = "",
        Code = "",
        EscapeST = "✺",
        Gavel = "",
        Glass = "",
        PyEnv = "",
        Squirrel = "",
        Tag = "",
        Tree = "",
        Watch = "",
        Lego = "",
        Vbar = "│",
        Add = "+",
        Added = "",
        Ghost = "",
        ManUp = "",
        Vim = "",
    },
    cmp = {
        Codeium = "",
        TabNine = "",
        Copilot = "",
        Copilot_alt = "",
        nvim_lsp = "",
        nvim_lua = "",
        path = "",
        buffer = "",
        spell = "暈",
        luasnip = "",
        treesitter = "",
    },
    dap = {
        Breakpoint = "",
        BreakpointCondition = "ﳁ",
        BreakpointRejected = "",
        LogPoint = "",
        Pause = "",
        Play = "",
        RunLast = "↻",
        StepBack = "",
        StepInto = "",
        StepOut = "",
        StepOver = "",
        Stopped = "",
        Terminate = "ﱢ",
    },
    
}

M.root_patterns = { ".git", "lua" }

---Get a specific icon set.
---@param category "kind"|"type"|"documents"|"git"|"ui"|"diagnostics"|"misc"|"cmp"|"dap"
---@param add_space? boolean @Add trailing space after the icon.
function M.geticons(category, add_space)
    if add_space then
        return setmetatable({}, {
            __index = function(_, key)
                return icons[category][key] .. " "
            end,
        })
    else
        return icons[category]
    end
end

---@param on_attach fun(client, buffer)
function M.on_attach(on_attach)
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            local buffer = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            on_attach(client, buffer)
        end,
    })
end

---@param plugin string
function M.has(plugin)
    return require("lazy.core.config").plugins[plugin] ~= nil
end

---@param fn fun()
function M.on_very_lazy(fn)
    vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
            fn()
        end,
    })
end

---@param name string
function M.opts(name)
    local plugin = require("lazy.core.config").plugins[name]
    if not plugin then
        return {}
    end
    local Plugin = require("lazy.core.plugin")
    return Plugin.values(plugin, "opts", false)
end

-- returns the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
---@return string
function M.get_root()
    ---@type string?
    local path = vim.api.nvim_buf_get_name(0)
    path = path ~= "" and vim.loop.fs_realpath(path) or nil
    ---@type string[]
    local roots = {}
    if path then
        for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
            local workspace = client.config.workspace_folders
            local paths = workspace and vim.tbl_map(function(ws)
                    return vim.uri_to_fname(ws.uri)
                end, workspace) or client.config.root_dir and { client.config.root_dir } or {}
            for _, p in ipairs(paths) do
                local r = vim.loop.fs_realpath(p)
                if path:find(r, 1, true) then
                    roots[#roots + 1] = r
                end
            end
        end
    end
    table.sort(roots, function(a, b)
        return #a > #b
    end)
    ---@type string?
    local root = roots[1]
    if not root then
        path = path and vim.fs.dirname(path) or vim.loop.cwd()
        ---@type string?
        root = vim.fs.find(M.root_patterns, { path = path, upward = true })[1]
        root = root and vim.fs.dirname(root) or vim.loop.cwd()
    end
    ---@cast root string
    return root
end

-- this will return a function that calls telescope.
-- cwd will default to lazyvim.util.get_root
-- for `files`, git_files or find_files will be chosen depending on .git

function M.telescope(builtin, opts)
    local params = { builtin = builtin, opts = opts, mychc = opts }
    return function()
        builtin = params.builtin
        opts = params.opts
        opts = vim.tbl_deep_extend("force", { cwd = M.get_root() }, opts or {})
        if builtin == "files" then
            if vim.loop.fs_stat((opts.cwd or vim.loop.cwd()) .. "/.git") then
                opts.show_untracked = true
                builtin = "git_files"
            else
                builtin = "find_files"
            end
        end
        require("telescope.builtin")[builtin](opts)
    end
end

-- FIXME: create a togglable terminal
-- Opens a floating terminal (interactive by default)
---@param cmd? string[]|string
---@param opts? LazyCmdOptions|{interactive?:boolean}
function M.float_term(cmd, opts)
    opts = vim.tbl_deep_extend("force", {
        size = { width = 0.8, height = 0.8 },
    }, opts or {})
    require("lazy.util").float_term(cmd, opts)
end

---@param silent boolean?
---@param values? {[1]:any, [2]:any}
function M.toggle(option, silent, values)
    if values then
        if vim.opt_local[option]:get() == values[1] then
            vim.opt_local[option] = values[2]
        else
            vim.opt_local[option] = values[1]
        end
        return Util.info("Set " .. option .. " to " .. vim.opt_local[option]:get(), { title = "Option" })
    end
    vim.opt_local[option] = not vim.opt_local[option]:get()
    if not silent then
        if vim.opt_local[option]:get() then
            Util.info("Enabled " .. option, { title = "Option" })
        else
            Util.warn("Disabled " .. option, { title = "Option" })
        end
    end
end

local enabled = true
function M.toggle_diagnostics()
    enabled = not enabled
    if enabled then
        vim.diagnostic.enable()
        Util.info("Enabled diagnostics", { title = "Diagnostics" })
    else
        vim.diagnostic.disable()
        Util.warn("Disabled diagnostics", { title = "Diagnostics" })
    end
end

function M.deprecate(old, new)
    Util.warn(("`%s` is deprecated. Please use `%s` instead"):format(old, new), { title = "Neovim" })
end

-- delay notifications till vim.notify was replaced or after 500ms
function M.lazy_notify()
    local notifs = {}
    local function temp(...)
        table.insert(notifs, vim.F.pack_len(...))
    end

    local orig = vim.notify
    vim.notify = temp

    local timer = vim.loop.new_timer()
    local check = vim.loop.new_check()

    local replay = function()
        timer:stop()
        check:stop()
        if vim.notify == temp then
            vim.notify = orig -- put back the original notify if needed
        end
        vim.schedule(function()
            ---@diagnostic disable-next-line: no-unknown
            for _, notif in ipairs(notifs) do
                vim.notify(vim.F.unpack_len(notif))
            end
        end)
    end

    -- wait till vim.notify has been replaced
    check:start(function()
        if vim.notify ~= temp then
            replay()
        end
    end)
    -- or if it took more than 500ms, then something went wrong
    timer:start(500, 0, replay)
end

return M
