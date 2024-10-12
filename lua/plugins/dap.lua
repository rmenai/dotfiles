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

      dap.adapters.cppdbg = {
        id = "cppdbg",
        type = "executable",
        command = "/opt/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
      }

      dap.configurations.c = {
        {
          name = "Launch file",
          type = "cppdbg",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopAtEntry = true,
        },
        {
          name = "Attach to gdbserver :1234",
          type = "cppdbg",
          request = "launch",
          MIMode = "gdb",
          miDebuggerServerAddress = "localhost:1234",
          miDebuggerPath = "/usr/bin/gdb",
          cwd = "${workspaceFolder}",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
        },
      }

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
