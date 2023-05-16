---@type Config

local M = {}

M.lazy_version = ">=9.1.0"
local defaults = {
    colorscheme = function()
        require("tokyonight").load()
        -- require("defaults").load()
        -- require("onedarkpro").load()
    end,
    -- icons used by other plugins
    icons = {
        diagnostics = {
            Error = " ",
            Warn = " ",
            Hint = " ",
            Info = " ",
        },
        git = {
            added = " ",
            modified = " ",
            removed = " ",
        },
        kinds = {
            Array = " ",
            Boolean = " ",
            Class = " ",
            Color = " ",
            Constant = " ",
            Constructor = " ",
            Copilot = " ",
            Enum = " ",
            EnumMember = " ",
            Event = " ",
            Field = " ",
            File = " ",
            Folder = " ",
            Function = " ",
            Interface = " ",
            Key = " ",
            Keyword = " ",
            Method = " ",
            Module = " ",
            Namespace = " ",
            Null = " ",
            Number = " ",
            Object = " ",
            Operator = " ",
            Package = " ",
            Property = " ",
            Reference = " ",
            Snippet = " ",
            String = " ",
            Struct = " ",
            Text = " ",
            TypeParameter = " ",
            Unit = " ",
            Value = " ",
            Variable = " ",
        },
    },
}
---@type Config
local options

---@param opts? Config
function M.setup(opts)
    options = vim.tbl_deep_extend("force", defaults, opts or {})
            --加载我的配置 
        M.load("autocmds")
        M.load("keymaps")
--尝试加载我的主题
    require("lazy.core.util").try(function()
        if type(M.colorscheme) == "function" then
            M.colorscheme()
        else
            vim.cmd.colorscheme(M.colorscheme)
        end
    end, {
        msg = "Could not load your colorscheme",
        on_error = function(msg)
            require("lazy.core.util").error(msg)
            vim.cmd.colorscheme("habamax")
        end,
    })
end


---@param 加载配置 "autocmds" | "options" | "keymaps"
function M.load(name)
    local Util = require("lazy.core.util")
    local function _load(mod)
        Util.try(function()
            require(mod)
        end, {
            msg = "Failed loading " .. mod,
            on_error = function(msg)
                local info = require("lazy.core.cache").find(mod)
                if info == nil or (type(info) == "table" and #info == 0) then
                    return
                end
                Util.error(msg)
            end,
        })
    end
    _load("config." .. name)
end

M.did_init = false  --保证加载一次
function M.init()
    if not M.did_init then
        M.did_init = true
        --  展示通知
        require("util").lazy_notify()
        --保证options先被加载
        require("config").load("options")
    end
end
--检查版本号
function M.has(range)
    local Semver = require("lazy.manage.semver")
    return Semver.range(range or M.lazy_version):matches(require("lazy.core.config").version or "0.0.0")
end
--访问M表中不存在的键时，能够从默认值或者特定的options表中获取对应的值。这种技巧在Lua中经常被用于实现默认参数或者选项
setmetatable(M, {
    __index = function(_, key)
        if options == nil then
            return vim.deepcopy(defaults)[key]
        end
        ---@cast options Config
        return options[key]
    end,
})
return M
