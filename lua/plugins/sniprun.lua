return {
  {
    "michaelb/sniprun",
    keys = {
      { "<S-r>", "<cmd>SnipRun<cr>" },
    },
    opts = {
      selected_interpreters = { "Some_interpreter", "Python3_fifo", "Cpp_original" },
      repl_enable = { "clangd" },
      repl_disable = {},
      interpreter_options = _G.interpreter_options,
      display = { "TempFloatingWindowOk" },
      display_options = {
        terminal_width = 45,
        notification_timeout = 5000,
      },
      inline_messages = 0,
      borders = "single",
			interactive=1,
    },
    config = function()
      -- 在这里添加其他配置
			interpreter_options = {
				Cpp_original = {
					compiler = "clang --debug",
					flags="-Wall",
					standard="c++17",
					interpreter="./a.out",
					interpreter_args="-a",
					repl_command="cling",
					repl_args="-std=c++17",
				},
			}
    end,
  },
}