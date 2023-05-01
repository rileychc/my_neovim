local dap_ft = "python,c,cpp"

return {
    {"mfussenegger/nvim-dap-python",},
    {
        "jayp0521/mason-nvim-dap.nvim", --依赖插件
        opts = { automatic_setup = true },
    },
    {
        "Weissle/persistent-breakpoints.nvim",--断点插件
        event = { "BufReadPost" },
        opts = { load_breakpoints_event = { "BufReadPost" } },
        keys = {
            { "<2-LeftMouse>", "<cmd>PBToggleBreakpoint<CR>",         desc = "toggle breakpont" },
            { "<leader>db",    "<cmd>PBToggleBreakpoint<CR>",         desc = "toggle breakpiont" },
            { "<leader>dc",    "<cmd>PBClearAllBreakpoints<CR>",      desc = "clear breakpiont" },
            { "<leader>dB",    "<cmd>PBSetConditionalBreakpoint<CR>", desc = "condition breakpiont" } },
    },
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            {
                "theHamsta/nvim-dap-virtual-text",
                opts = {
                    enabled = true,
                    enable_commands = true,             --创建命令DapVirtualTextEnable，DapVirtualTextDisable，DapVirtualTextToggle，（当调试适配器没有通知其终止时，DapVirtualTextForceRefresh用于刷新）
                    highlight_changed_variables = true, --使用NvimDapVirtualTextChanged突出显示更改的值，否则总是NvimDapVirtualText
                    highlight_new_as_changed = true,    --以与更改变量相同的方式突出显示新变量（如果highlight_changed_variables）
                    show_stop_reason = true,            --当因异常而停止时显示停止原因
                    commented = true,                   --用注释字符串前缀虚拟文本
                    only_first_definition = true,       --仅在第一个定义时显示虚拟文本（如果有多个）
                    all_references = false,             --在变量的所有引用上显示虚拟文本（不仅仅是定义）
                    filter_references_pattern = '<module',
                    virt_text_pos = 'eol',              --虚拟文本的位置，请参阅`:h nvim_buf_set_extmark()`
                    all_frames = false,                 --显示所有堆栈帧的虚拟文本，而不仅仅是当前。仅适用于我的机器上的调试。
                    virt_lines = false,                 --显示虚拟行而不是虚拟文本（将闪烁！）
                    virt_text_win_col = nil,
                },                                      --将虚拟文本放置在固定窗口列（从第一个文本列开始），
                ----例如80到第80列的位置，请参阅`:h nvim_buf_set_extmark()`
                -- display_callback = function(variable, _buf, _stackframe, _node) --确定变量如何显示或是否应省略的回调
                --   return variable.name .. ' = ' .. variable.value
                -- end,

            },
            require("plugins.dap.dap-ui"),
        },
        ft = vim.split(dap_ft, ""),
        keys = {
            { "<F17>", "<cmd>DapTerminate<CR>",       desc = "quit debug" },    --停止
            { "<F41>", "<cmd>DapRestartFrame<CR>",    desc = "restart debug" }, --重新开始
            { "<F5>",  "<cmd>DapContinue<CR>",        desc = "start debug" },   --开始或继续
            { "<F23>", "<cmd>DapStepOut<CR>",         desc = "Step Out" },      --跳出
            { "<F9>",  "<cmd>PBToggleBreakpoint<CR>", desc = "ToggleBreakpoint" },--切换断点
            { "<F10>", "<cmd>DapStepOver<CR>",        desc = "Step Over" },
            { "<F11>", "<cmd>DapStepInto<CR>",        desc = "Step Into" },
        },
        config = function()
            -- dap signs defined in plugins/ui/signs
            require("mason-nvim-dap").default_setup({
                function(source_name)
                    require("mason-nvim-dap.automatic_setup")(source_name)
                end,
            })
            require("plugins.dap.adapters")
        end,
    },
}
