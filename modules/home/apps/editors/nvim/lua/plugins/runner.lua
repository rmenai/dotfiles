return {
  {
    "stevearc/overseer.nvim",
    cmd = { "OverseerToggle", "OverseerRun" },
    opts = {
      dap = true,
      templates = { "builtin", "custom" },
      task_list = {
        direction = "right",
      },
    },
    keys = {
      { "<leader>ro", "<cmd>OverseerToggle<cr>", desc = "Toggle Output (Overseer)" },
      { "<leader>rr", "<cmd>OverseerRun<cr>", desc = "Open Task List (Overseer)" },
      {
        "<leader>rl",
        function()
          local overseer = require("overseer")
          local tasks = overseer.list_tasks({ recent_first = true })
          if vim.tbl_isempty(tasks) then
            vim.cmd("OverseerRun") -- No tasks? Open the menu
          else
            overseer.run_action(tasks[1], "restart") -- Tasks exist? Restart the last one
          end
        end,
        desc = "Run Last (Overseer)",
      },
    },
  },

  {
    "michaelb/sniprun",
    branch = "master",
    build = "sh ./install.sh 1",
    opts = {
      display = { "TerminalWithCode" },
      live_mode_toggle = "off",
      display_options = {
        terminal_position = "horizontal",
        terminal_height = 15,
      },

      repl_enable = { "OCaml_fifo", "Python3_original", "Rust_original" },
    },
    keys = {
      { "<leader>rs", "<cmd>SnipRun<cr>", mode = { "n", "v" }, desc = "Run Snippet (SnipRun)" },
      { "<leader>rf", "<cmd>%SnipRun<cr>", mode = { "n" }, desc = "Run Current File (SnipRun)" },
    },
  },

  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>r", group = "run" },
      },
    },
  },

  {
    "nvim-neotest/neotest",
    opts = function(_, opts)
      opts.consumers = opts.consumers or {}
      opts.consumers.overseer = require("neotest.consumers.overseer")
    end,
  },

  {
    "mfussenegger/nvim-dap",
    opts = function() require("overseer").enable_dap() end,
  },

  {
    "catppuccin",
    opts = { integrations = { overseer = true } },
  },

  {
    "folke/snacks.nvim",
    opts = {
      terminal = {
        win = {
          height = 18,
        },
      },
    },
  },
}
