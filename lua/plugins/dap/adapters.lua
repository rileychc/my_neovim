local dap = require("dap")

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
    name = "C/C++debug",
    request = "launch",
    -- 编译输出目录在 cwd/build/,和asynctask中定义的一致
    program= "~/Public/Bin_Files/a.out",
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
