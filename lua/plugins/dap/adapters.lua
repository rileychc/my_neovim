local dap = require("dap")

-- local dapui = require("dapui")
-- dapui.setup({})

-- dap.listeners.after.event_initialized["dapui_config"] = function()
--   dapui.open({})
-- end

-- dap.listeners.before.event_terminated["dapui_config"] = function()
--   dapui.close({})
-- end

-- dap.listeners.before.event_exited["dapui_config"] = function()
--   dapui.close({})
-- end


-- load tasks
-- require("dap.ext.vscode").load_launchjs(
-- file path tbl
--   ".vscode/launch.json",
-- nil,
--  {
--     python = { "python" },
--    cppdbg = { "c", "cpp" },
-- }
--)

--------------------------------------------------------------------------------
dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Python: Launch file",
    program = "${file}",
    console = "integratedTerminal",
  },
  {
    type = "python",
    request = "launch",
    name = "Python: Launch file ( with args )",
    program = "${file}",
    console = "integratedTerminal",
    args = {},
  },
}

--------------------------------------------------------------------------------
-- debug编译型语言, 编译参数必须设置成debug模式,如果release模式会闪退
-- 参考asynctask的设置
dap.adapters.lldb = {
  type = "excutable",
  command = "lldb",
  name = "lldb",
}
local lldb = {
  {
    type = "codelldb",
    name = "LLDB: Launch",
    request = "launch",
    -- 编译输出目录在 cwd/build/,和asynctask中定义的一致
    program = "${workspaceFolder}/a.out", --${fileBasenameNoExtension}
    console = "integratedTerminal",
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
    runInTerminal = false,
  },
}
-- c,cpp简单测试过可用
dap.configurations.c = lldb
dap.configurations.cpp = lldb
