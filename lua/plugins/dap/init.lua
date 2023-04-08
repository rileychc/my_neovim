local dap_ft = "python,c,cpp"

return {
  {
    "jayp0521/mason-nvim-dap.nvim",
    opts = { automatic_setup = true },
  },
  {
    "Weissle/persistent-breakpoints.nvim",
    event = { "BufReadPost" },
    opts = { load_breakpoints_event = { "BufReadPost" } },
    keys = {
      { "<2-LeftMouse>", "<cmd>PBToggleBreakpoint<CR>", desc = "toggle breakpont" },
    },
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      { "theHamsta/nvim-dap-virtual-text", config = true },
      require("plugins.dap.dap-ui"),
    },
    ft = vim.split(dap_ft, ""),
    keys = {
      { "<F17>", "<cmd>DapTerminate<CR>", desc = "quit debug" }, --停止
      { "<F41>", "<cmd>DapRestartFrame<CR>", desc = "restart debug" }, --重新开始
      { "<F5>", "<cmd>DapContinue<CR>", desc = "start debug" }, --开始或继续
      { "<F23>", "<cmd>DapStepOut<CR>", desc = "Step Out" }, --跳出
      { "<F9>", "<cmd>DapToggleBreakpoint<CR>", desc = "ToggleBreakpoint" },
      { "<F10>", "<cmd>DapStepOver<CR>", desc = "Step Over" },
      { "<F11>", "<cmd>DapStepInto<CR>", desc = "Step Into" },
    },
    config = function()
      -- dap signs defined in plugins/ui/signs
      require("mason-nvim-dap").setup_handlers({
        function(source_name)
          require("mason-nvim-dap.automatic_setup")(source_name)
        end,
      })
      require("plugins.dap.adapters")
    end,
  },
}
