return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "jay-babu/mason-nvim-dap.nvim",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "mfussenegger/nvim-dap-python",
    },
    cmd = { "DapNew", "DapTerminate", "DapToggleBreakpoint", "DapContinue" },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = "lldb",
          args = { "--port", "${port}" },
        },
      }

      dap.adapters.python = {
        type = "executable",
        command = "python",
        args = { "-m", "debugpy.adapter" },
      }

      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          pythonPath = function() return "python3" end,
        },
      }

      -- Initialize dapui
      dapui.setup()

      -- Setup listeners for dap
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

      require("mason-nvim-dap").setup({
        handlers = {
          function(config) require("mason-nvim-dap").default_setup(config) end,
        },
      })
    end,
  },
}
