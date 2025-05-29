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
      local repo_url = "git@github.com:rmenai/leetcode.git"

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

      -- Commit leetcode changes on neovim leave
      vim.api.nvim_create_autocmd("VimLeavePre", {
        group = vim.api.nvim_create_augroup("AutoGitCommit", { clear = true }),
        callback = function() utils.sync_repo(home_dir, repo_url) end,
      })
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

  -- AI
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
        filetypes = {
          markdown = true,
          help = true,
        },
      })

      vim.g.copilot_enabled = false
      vim.cmd("Copilot disable")
    end,
  },

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    cmd = {
      "CopilotChat",
      "CopilotChatFix",
      "CopilotChatDocs",
      "CopilotChatLoad",
      "CopilotChatOpen",
      "CopilotChatSave",
      "CopilotChatStop",
      "CopilotChatClose",
      "CopilotChatReset",
      "CopilotChatTests",
      "CopilotChatAgents",
      "CopilotChatCommit",
      "CopilotChatModels",
      "CopilotChatReview",
      "CopilotChatToggle",
      "CopilotChatExplain",
      "CopilotChatPrompts",
      "CopilotChatOptimize",
    },
    opts = {
      mappings = {
        submit_prompt = {
          normal = "<CR>",
          insert = "<C-CR>",
        },
        reset = {
          normal = "<C-c>",
          insert = "<C-c>",
        },
      },
    },
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
