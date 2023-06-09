return {

    -- copilot  暂时用不上
    {
        "zbirenbaum/copilot.lua",
        enabled = false,
        cmd = "Copilot",
        build = ":Copilot auth",
        opts = {
            suggestion = { enabled = false },
            panel = { enabled = false },
        },
        config = function()
            require('copilot').setup({
                panel = {
                    enabled = true,
                    auto_refresh = false,
                    keymap = {
                        jump_prev = "[[",
                        jump_next = "]]",
                        accept = "<CR>",
                        refresh = "gr",
                        open = "<M-CR>"
                    },
                    layout = {
                        position = "bottom", -- | top | left | right
                        ratio = 0.4
                    },
                },
                suggestion = {
                    enabled = true,
                    auto_trigger = false,
                    debounce = 75,
                    keymap = {
                        accept = "<M-l>",
                        accept_word = false,
                        accept_line = false,
                        next = "<M-]>",
                        prev = "<M-[>",
                        dismiss = "<C-]>",
                    },
                },
                filetypes = {
                    yaml = false,
                    markdown = false,
                    help = false,
                    gitcommit = false,
                    gitrebase = false,
                    hgcommit = false,
                    svn = false,
                    cvs = false,
                    ["."] = false,
                },
                copilot_node_command = 'node', -- Node.js version must be > 16.x
                server_opts_overrides = {},
            })
        end,
    },

    -- copilot cmp source
    -- {
    --     "nvim-cmp",

    --     dependencies = {
    --         {
    --             "zbirenbaum/copilot-cmp",
    --             dependencies = "copilot.lua",
    --             opts = {},
    --             config = function(_, opts)
    --                 local copilot_cmp = require("copilot_cmp")
    --                 copilot_cmp.setup(opts)
    --                 -- attach cmp source whenever copilot attaches
    --                 -- fixes lazy-loading issues with the copilot cmp source
    --                 require("util").on_attach(function(client)
    --                     if client.name == "copilot" then
    --                         copilot_cmp._on_insert_enter()
    --                     end
    --                 end)
    --             end,
    --         },
    --     },
    --     ---@param opts cmp.ConfigSchema
    --     opts = function(_, opts)
    --         local cmp = require("cmp")

    --         table.insert(opts.sources, 1, { name = "copilot", group_index = 2 })

    --         local confirm = opts.mapping["<CR>"]
    --         local confirm_copilot = cmp.mapping.confirm({
    --             select = true,
    --             behavior = cmp.ConfirmBehavior.Replace,
    --         })

    --         opts.mapping = vim.tbl_extend("force", opts.mapping, {
    --             ["<CR>"] = function(...)
    --                 local entry = cmp.get_selected_entry()
    --                 if entry and entry.source.name == "copilot" then
    --                     return confirm_copilot(...)
    --                 end
    --                 return confirm(...)
    --             end,
    --         })
    --         opts.sorting = {
    --             priority_weight = 2,
    --             comparators = {
    --                 require("copilot_cmp.comparators").prioritize,

    --                 -- Below is the default comparitor list and order for nvim-cmp
    --                 cmp.config.compare.offset,
    --                 -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
    --                 cmp.config.compare.exact,
    --                 cmp.config.compare.score,
    --                 cmp.config.compare.recently_used,
    --                 cmp.config.compare.locality,
    --                 cmp.config.compare.kind,
    --                 cmp.config.compare.sort_text,
    --                 cmp.config.compare.length,
    --                 cmp.config.compare.order,
    --             },
    --         }
    --     end,
    -- },
}
