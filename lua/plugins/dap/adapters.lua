local dap = require("dap")

-- load tasks
-- require("dap.ext.vscode").load_launchjs(
-- -- file path tbl
--   ".vscode/launch.json",
-- nil,
--  {
--     python = { "python" },
--    cppdbg = { "c", "cpp" },
-- }
-- )


--------------------------------------------------------------------------------
-- debug编译型语言, 编译参数必须设置成debug模式,如果release模式会闪退
dap.adapters.codelldb     = {
    --自动连接codelldb
    type = 'server',
    port = "${port}",
    executable = {
        -- CHANGE THIS to your path!
        command = 'codelldb',
        args = { "--port", "${port}" },

        --windows需取消注释
        -- detached = false,
    }
}
dap.configurations.cpp    = {
    {
        type = "codelldb",
        name = "C/C++调试",
        request = "launch",
        -- 编译输出目录在 cwd/build/,和asynctask中定义的一致
        program = "~/Public/Bin_Files/a.out",
        --       program = function()
        --         return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        --       end,
        console = "integratedTerminal",
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
        runInTerminal = false,
    },
}
dap.configurations.c      = dap.configurations.cpp

dap.adapters.python       = function(cb, config)
    if config.request == 'attach' then
        ---@diagnostic disable-next-line: undefined-field
        local port = (config.connect or config).port
        ---@diagnostic disable-next-line: undefined-field
        local host = (config.connect or config).host or '127.0.0.1'
        cb({
            type = 'server',
            port = assert(port, '`connect.port` is required for a python `attach` configuration'),
            host = host,
            options = {
                source_filetype = 'python',
            },
        })
    else
        cb({
            type = 'executable',
            -- command = '/Users/riley/.virtualenvs/debugpy/bin/python3',
            command = '/opt/homebrew/bin/python3',
            args = { '-m', 'debugpy.adapter' },
            options = {
                source_filetype = 'python',
            },
        })
    end
end

dap.configurations.python = {
    {
        -- The first three options are required by nvim-dap
        type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
        request = 'launch',
        name = "Launch file",
        console = "integratedTerminal",
        -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

        program = "${file}", -- This configuration will launch the current file if used.
        pythonPath = function()
            -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
            -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
            -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
            -- local cwd = vim.fn.getcwd()
            -- if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
            --   return cwd .. '/venv/bin/python'
            -- elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
            --   return cwd .. '/.venv/bin/python'
            -- else
            -- return '/usr/bin/python'
            return '/opt/homebrew/bin/python3'
            -- end
        end,
    },
}
