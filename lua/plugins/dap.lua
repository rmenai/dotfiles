return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/cmp-dap",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    cmd = { "DapNew", "DapTerminate", "DapToggleBreakpoint", "DapContinue" },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dap.adapters.ocaml = {
        type = "executable",
        command = "ocamlearlybird",
        args = { "debug" },
        cwd = "${workspaceFolder}",
      }

      dap.configurations.ocaml = {
        {
          type = "ocaml",
          request = "launch",
          name = "Launch debug test",
          console = "integratedTerminal",
          program = "_build/default/${relativeFileDirname}/${fileBasenameNoExtension}.bc",
          cwd = "${workspaceFolder}",
          stopOnEntry = true,
          yieldSteps = 4096,
          onlyDebugGlob = "<${workspaceFolder}/**/*>",
        },
      }

      -- Initialize dapui
      dapui.setup()

      -- Setup listeners for dap
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
    end,
  },
}
