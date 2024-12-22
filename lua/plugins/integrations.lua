return {
  {
    "kawre/leetcode.nvim",
    lazy = vim.fn.argv()[1] ~= "leet",
    cmd = "Leet",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      local utils = require("core.utils")

      local home_dir = vim.fn.stdpath("data") .. "/leetcode"
      local repo_url = "https://github.com/rmenai/leetcode.git"

      -- Sync repo on start
      if vim.fn.isdirectory(home_dir) == 0 then utils.sync_repo(home_dir, repo_url) end

      require("leetcode").setup({
        storage = { home = home_dir .. "/solutions" },
        plugins = { non_standalone = true },
        injector = {
          ["c"] = {
            before = {
              "#include <stdlib.h>",
            },
          },
        },
        arg = "leet",
        lang = "rust",
      })

      -- Set up commands
      require("core.commands").setup_leetcode_cmds()

      -- Set up autocmds
      require("core.autocmds").leetcode_autocmd(function() utils.sync_repo(home_dir, repo_url) end)
    end,
  },

  {
    "p00f/godbolt.nvim",
    cmd = { "Godbolt", "GodboltCompiler" },
    config = function()
      require("godbolt").setup({
        highlight = {
          cursor = "Visual",
          static = false,
        },
      })
    end,
  },

  -- Games
  {
    "NStefan002/speedtyper.nvim",
    cmd = "Speedtyper",
    config = function() require("speedtyper").setup({}) end,
  },
  {
    "ThePrimeagen/vim-be-good",
    cmd = "VimBeGood",
    config = false,
  },
  {
    "eandrju/cellular-automaton.nvim",
    cmd = "CellularAutomaton",
    config = false,
  },
  {
    "jim-fx/sudoku.nvim",
    cmd = "Sudoku",
    config = function() require("sudoku").setup({}) end,
  },
}
