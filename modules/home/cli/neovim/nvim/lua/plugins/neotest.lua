return {
  {
    "nvim-neotest/neotest",
    keys = {
      -- Disable original keys (t, T, r)
      { "<leader>tt", false },
      { "<leader>tT", false },
      { "<leader>tr", false },

      {
        "<leader>tr",
        function() require("neotest").summary.toggle() end,
        desc = "Toggle Summary (Neotest)",
      },
      {
        "<leader>tf",
        function() require("neotest").run.run(vim.fn.expand("%")) end,
        desc = "Run File (Neotest)",
      },
      {
        "<leader>tF",
        function() require("neotest").run.run(vim.uv.cwd()) end,
        desc = "Run All Test Files (Neotest)",
      },
      {
        "<leader>tn",
        function() require("neotest").run.run() end,
        desc = "Run Nearest (Neotest)",
      },

      {
        "<leader>to",
        function() require("neotest").output_panel.toggle() end,
        desc = "Toggle Output Panel (Neotest)",
      },

      {
        "<leader>tO",
        function() require("neotest").output.open({ enter = true, auto_close = true }) end,
        desc = "Show Output (Neotest)",
      },
    },
  },
}
