local icons = {
    cmp = require("util").geticons("cmp", true),
    diagnostics = require("util").geticons("diagnostics", true),
    kind = require("util").geticons("kind", true),
    type = require("util").geticons("type", true),
    ui = require("util").geticons("ui", true),
}
local function set_sidebar_icons()
    -- Set icons for sidebar.
    local diagnostic_icons = {
        Error = icons.diagnostics.Error_alt,
        Warn = icons.diagnostics.Warning_alt,
        Info = icons.diagnostics.Information_alt,
        Hint = icons.diagnostics.Hint_alt,
    }
    for type, icon in pairs(diagnostic_icons) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl })
    end
end
return {
    {"mfussenegger/nvim-jdtls",lazy=true,},--java
    { "nvim-tree/nvim-web-devicons", lazy = true, }, --lspsaga 依赖
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
        --     { "folke/neoconf.nvim", event="VeryLazy",--管理全局和项目本地设置的插件。
        --     cmd = "Neoconf", config = true 
        -- },
        --     {--自动配置lua语言服务器
        --         "folke/neodev.nvim",
        --         event="VeryLazy",
        --         opts = {
        --             experimental = { pathStrict = true },
        --             library = { plugins = { "nvim-dap-ui" }, types = true }
        --         }
        --     }, --library  我加上
            "williamboman/mason-lspconfig.nvim",
            {
                "hrsh7th/cmp-nvim-lsp",
                cond = function()
                    return require("util").has("nvim-cmp")
                end,
            },
            { "b0o/SchemaStore.nvim", version = false, }, -- last release is way too old
        },
        ---@class PluginLspOpts
        opts = {
            -- options for vim.diagnostic.config()
            diagnostics = {
                underline = true,
                update_in_insert = false,
                virtual_text = { spacing = 4, prefix = "●" },
                severity_sort = true,
            },
            -- Automatically format on save
            autoformat = true,
            -- options for vim.lsp.buf.format
            -- `bufnr` and `filter` is handled by the LazyVim formatter,
            -- but can be also overridden when specified
            format = {
                formatting_options = nil,
                timeout_ms = nil,
            },
            -- LSP Server Settings
            ---@type lspconfig.options
            servers = {
                -- clangd = { settings = { offsetEncoding = "utf-16" } }, --我加上的
                pyright = {}, --加上
                jsonls = {
                    -- lazy-load schemastore when needed
                    on_new_config = function(new_config)
                        new_config.settings.json.schemas = new_config.settings.json.schemas or {}
                        vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
                    end,
                    settings = {
                        json = {
                            format = {
                                enable = true,
                            },
                            validate = { enable = true },
                        },
                    },
                },
                lua_ls = {
                    -- mason = false, -- set to false if you don't want this server to be installed with mason
                    settings = {
                        Lua = {
                            workspace = {
                                checkThirdParty = false,
                            },
                            completion = {
                                callSnippet = "Replace",
                            },
                        },
                    },
                },
            },
            -- you can do any additional lsp server setup here
            -- return true if you don't want this server to be setup with lspconfig
            ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
            setup = {
                -- example to setup with typescript.nvim
                -- tsserver = function(_, opts)
                --   require("typescript").setup({ server = opts })
                --   return true
                -- end,
                -- Specify * to use this function as a fallback for any server
                -- ["*"] = function(server, opts) end,
            },
        },
        ---@param opts PluginLspOpts
        config = function(_, opts)

            
            -- setup autoformat
            require("plugins.lsp.format").autoformat = opts.autoformat
            -- setup formatting and keymaps
            require("util").on_attach(function(client, buffer)
                require("plugins.lsp.format").on_attach(client, buffer)
                require("plugins.lsp.keymaps").on_attach(client, buffer)
            end)



            -- diagnostics
            for name, icon in pairs(require("config").icons.diagnostics) do
                name = "DiagnosticSign" .. name
                vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
            end
            vim.diagnostic.config(opts.diagnostics)
            
             
            local servers = opts.servers
            local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

            local function setup(server)
                local server_opts = vim.tbl_deep_extend("force", {
                    capabilities = vim.deepcopy(capabilities),
                }, servers[server] or {})

                if opts.setup[server] then
                    if opts.setup[server](server, server_opts) then
                        return
                    end
                elseif opts.setup["*"] then
                    if opts.setup["*"](server, server_opts) then
                        return
                    end
                end
                require("lspconfig")[server].setup(server_opts)
            end

            -- get all the servers that are available thourgh mason-lspconfig
            local have_mason, mlsp = pcall(require, "mason-lspconfig")
            local all_mslp_servers = {}
            if have_mason then
                all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
            end

            local ensure_installed = {} ---@type string[]
            for server, server_opts in pairs(servers) do
                if server_opts then
                    server_opts = server_opts == true and {} or server_opts
                    -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
                    if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
                        setup(server)
                    else
                        ensure_installed[#ensure_installed + 1] = server
                    end
                end
            end

            if have_mason then
                mlsp.setup({ ensure_installed = ensure_installed })
                mlsp.setup_handlers({ setup })
            end
        
        end,
    },
    {
        "glepnir/lspsaga.nvim",
        event = "LspAttach",
        dependencies = { "nvim-web-devicons" }, -- 使用的是本地图标
        config = function()
            set_sidebar_icons()
            require("lspsaga").setup({
                preview = {
                    lines_above = 1,
                    lines_below = 17,
                },
                request_timeout = 3000,
                finder = {
                    keys = {
                        jump_to = "e",
                        expand_or_jump = "<CR>",
                        vsplit = "s",
                        split = "i",
                        tabe = "t",
                        quit = { "q", "<ESC>" },
                        close_in_preview = "<ESC>",
                    },
                },
                definition = {
                    edit = "<C-c>o",
                    vsplit = "<C-c>v",
                    split = "<C-c>s",
                    tabe = "<C-c>t",
                    quit = "q",
                },
                code_action = {
                    keys = {
                        quit = "q",
                        exec = "<CR>",
                    },
                },
                lightbulb = {
                    enable = false,
                    sign = true,
                    enable_in_insert = true,
                    sign_priority = 20,
                    virtual_text = false,
                },
                diagnostic = {
                    text_hl_follow = true, --默认为假，您可以定义DiagnostcText来自定义诊断文本颜色
                    on_insert = true,
                    on_insert_follow = false,
                    border_follow = true,
                    extend_relatedInformation = false,
                },
                rename = {
                    quit = "<Esc>",
                    mark = "x",
                    confirm = "<CR>",
                    exec = "<CR>",
                    in_select = true,
                },
                hover = {
                    open_link = "gl",
                    open_browser = '!safari',
                },
                outline = {
                    win_position = "right",
                    win_with = "_sagaoutline",
                    win_width = 30,
                    auto_preview = true,
                    auto_refresh = true,
                    auto_close = true,
                    close_after_jump = true,
                    keys = {
                        expand_or_jump = "<CR>",
                        quit = "q",
                    },
                },
                symbol_in_winbar = {
                    enable = false,
                    separator = " " .. icons.ui.Separator,
                    hide_keyword = true,
                    show_file = false,
                    color_mode = true,
                },
                beacon = {
                    enable = true,
                    frequency = 12,
                },
                ui = {
                    border = "single", -- Can be single, double, rounded, solid, shadow.
                    winblend = 0,
                    actionfix = icons.ui.Spell,
                    expand = icons.ui.ArrowClosed,
                    collapse = icons.ui.ArrowOpen,
                    code_action = icons.ui.CodeAction,
                    incoming = icons.ui.Incoming,
                    outgoing = icons.ui.Outgoing,
                    kind = {
                        -- Kind
                        Class = { icons.kind.Class, "LspKindClass" },
                        Constant = { icons.kind.Constant, "LspKindConstant" },
                        Constructor = { icons.kind.Constructor, "LspKindConstructor" },
                        Enum = { icons.kind.Enum, "LspKindEnum" },
                        EnumMember = { icons.kind.EnumMember, "LspKindEnumMember" },
                        Event = { icons.kind.Event, "LspKindEvent" },
                        Field = { icons.kind.Field, "LspKindField" },
                        File = { icons.kind.File, "LspKindFile" },
                        Function = { icons.kind.Function, "LspKindFunction" },
                        Interface = { icons.kind.Interface, "LspKindInterface" },
                        Key = { icons.kind.Keyword, "LspKindKey" },
                        Method = { icons.kind.Method, "LspKindMethod" },
                        Module = { icons.kind.Module, "LspKindModule" },
                        Namespace = { icons.kind.Namespace, "LspKindNamespace" },
                        Number = { icons.kind.Number, "LspKindNumber" },
                        Operator = { icons.kind.Operator, "LspKindOperator" },
                        Package = { icons.kind.Package, "LspKindPackage" },
                        Property = { icons.kind.Property, "LspKindProperty" },
                        Struct = { icons.kind.Struct, "LspKindStruct" },
                        TypeParameter = { icons.kind.TypeParameter, "LspKindTypeParameter" },
                        Variable = { icons.kind.Variable, "LspKindVariable" },
                        -- Type
                        Array = { icons.type.Array, "LspKindArray" },
                        Boolean = { icons.type.Boolean, "LspKindBoolean" },
                        Null = { icons.type.Null, "LspKindNull" },
                        Object = { icons.type.Object, "LspKindObject" },
                        String = { icons.type.String, "LspKindString" },
                        -- ccls-specific icons.
                        TypeAlias = { icons.kind.TypeAlias, "LspKindTypeAlias" },
                        Parameter = { icons.kind.Parameter, "LspKindParameter" },
                        StaticMethod = { icons.kind.StaticMethod, "LspKindStaticMethod" },
                        -- Microsoft-specific icons.
                        Text = { icons.kind.Text, "LspKindText" },
                        Snippet = { icons.kind.Snippet, "LspKindSnippet" },
                        Folder = { icons.kind.Folder, "LspKindFolder" },
                        Unit = { icons.kind.Unit, "LspKindUnit" },
                        Value = { icons.kind.Value, "LspKindValue" },
                    },
                }
            })
        end,
    }
}




















--TypeScript 语言服务器
-- add tsserver and setup with typescript.nvim instead of lspconfig
-- correctly setup lspconfig
--   { "neovim/nvim-lspconfig",
--     dependencies = { "jose-elias-alvarez/typescript.nvim" },
--     opts = {
--         -- make sure mason installs the server

--         servers = {
--             ---@type lspconfig.options.tsserver
--             tsserver = {
--                 settings = {
--                     completions = {
--                         completeFunctionCalls = true,
--                     },
--                 },
--             },
--         },
--         setup = {
--             tsserver = function(_, opts)
--                 local lspconfig = require("lspconfig")

--                 require("util").on_attach(function(client, buffer)
--                     if client.name == "tsserver" then
--                         -- stylua: ignore
--                         vim.keymap.set("n", "<leader>co", "<cmd>TypescriptOrganizeImports<CR>",
--                             { buffer = buffer, desc = "Organize Imports" })
--                         -- stylua: ignore
--                         vim.keymap.set("n", "<leader>cR", "<cmd>TypescriptRenameFile<CR>",
--                             { desc = "Rename File", buffer = buffer })
--                     end
--                 end)
--                 require("typescript").setup({ server = opts })
--                 return true
--             end,
--         },
--     },
-- },

--这是javascript
-- return {
--     {
--         "neovim/nvim-lspconfig",
--         -- other settings removed for brevity
--         opts = {
--             servers = {
--                 eslint = {
--                     settings = {
--                         -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
--                         workingDirectory = { mode = "auto" },
--                     },
--                 },
--             },
--             setup = {
--                 eslint = function()
--                     vim.api.nvim_create_autocmd("BufWritePre", {
--                         callback = function(event)
--                             if require("lspconfig.util").get_active_client_by_name(event.buf, "eslint") then
--                                 vim.cmd("EslintFixAll")
--                             end
--                         end,
--                     })
--                 end,
--             },
--         },
--     },
