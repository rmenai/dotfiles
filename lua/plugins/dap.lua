return {
  {
    "rcarriga/nvim-dap-ui",
    keys = { "<F5>", "<F6>", "<F7>", "<F8>", "gb", "gB" },
    cmd = { "DapNew", "DapTerminate" },
    dependencies = {
      "rcarriga/cmp-dap",
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Initialize dapui
      dapui.setup()

      -- Setup listeners for dap
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Set up mappings
      require("core.mappings").map_dap()
    end,
  },
}
