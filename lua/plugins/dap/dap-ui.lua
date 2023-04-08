local opts = {

    icons = { expanded = "▾", collapsed = "▸" ,circular="↺"},
    mappings = {
        expand = { "o", "<2-LeftMouse>", "<CR>" },
        open = "O",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
    },
    expand_lines = vim.fn.has("nvim-0.7") == 1,
    layouts = {
        {
            elements = {
                -- Can be float or integer > 1
                { id = "scopes", size = 0.5 },
                { id = "watches", size = 0.30 },
                { id = "stacks", size = 0.15 },
                { id = "breakpoints", size = 0.10 },
            },
            size = 40,
            position = "left",
        },
        {
            elements = {
                { id = "console", size = 0.6 },
                { id = "repl", size = 0.7 },
            },
            size = 10,
            position = "bottom",
        },
    },
  
    controls = {
        element = "console",
    },
   -- controls = {enabled = false},
    floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        border = "single", -- Border style. Can be "single", "double" or "rounded"
        mappings = {
            close = { "q", "<Esc>" },
        },
    },

    windows = { indent = 1 },
    -- windows = { indent = 1 },
    render = {
        max_type_length = nil, -- Can be integer or nil.
        max_value_lines = 100, -- Can be integer or nil.
    },
    enabled = true,
    enable_commands = true,
    highlight_changed_variables = true,
    highlight_new_as_changed = false,
    show_stop_reason = true,
    commented = false,
    only_first_definition = true,
    all_references = false,
    filter_references_pattern = '<module',
    virt_text_pos = 'eol',
    all_frames = false,
    virt_lines = false,
    virt_text_win_col = nil
}

return {
    "rcarriga/nvim-dap-ui",
    config = function()
        local dap, dapui = require("dap"), require("dapui")
        dapui.setup(opts)

        local debug_open = function()
            dapui.open({})
        end
        local debug_close = function()
            dap.repl.close()
            dapui.close({})
        end

        dap.listeners.after.event_initialized["dapui_config"] = debug_open
        dap.listeners.before.event_terminated["dapui_config"] = debug_close
        dap.listeners.before.event_exited["dapui_config"] = debug_close
        dap.listeners.before.disconnect["dapui_config"] = debug_close
   



    local dap_breakpoint_color = {
        breakpoint = {
            ctermbg=0,
            fg='#993939',
            bg='#31353f',
        },
        logpoing = {
            ctermbg=0,
            fg='#61afef',
            bg='#31353f',
        },
        stopped = {
            ctermbg=0,
            fg='#98c379',
            bg='#31353f'
        },
    }
    
    vim.api.nvim_set_hl(0, 'DapBreakpoint', dap_breakpoint_color.breakpoint)
    vim.api.nvim_set_hl(0, 'DapLogPoint', dap_breakpoint_color.logpoing)
    vim.api.nvim_set_hl(0, 'DapStopped', dap_breakpoint_color.stopped)
    
    local dap_breakpoint = {
        error = {
            text = "",
            texthl = "DapBreakpoint",
            linehl = "DapBreakpoint",
            numhl = "DapBreakpoint",
        },
        condition = {
            text = 'ﳁ',
            texthl = 'DapBreakpoint',
            linehl = 'DapBreakpoint',
            numhl = 'DapBreakpoint',
        },
        rejected = {
            text = "",
            texthl = "DapBreakpint",
            linehl = "DapBreakpoint",
            numhl = "DapBreakpoint",
        },
        logpoint = {
            text = '',
            texthl = 'DapLogPoint',
            linehl = 'DapLogPoint',
            numhl = 'DapLogPoint',
        },
        stopped = {
            text = '',
            texthl = 'DapStopped',
            linehl = 'DapStopped',
            numhl = 'DapStopped',
        },
    }
  --vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''}),
    
    vim.fn.sign_define('DapBreakpoint', dap_breakpoint.error)
    vim.fn.sign_define('DapBreakpointCondition', dap_breakpoint.condition)
    vim.fn.sign_define('DapBreakpointRejected', dap_breakpoint.rejected)
    vim.fn.sign_define('DapLogPoint', dap_breakpoint.logpoint)
    vim.fn.sign_define('DapStopped', dap_breakpoint.stopped)


end,

}


