local obsidian_vault = { name = "notes", path = "~/Documents/notes" }

return {
  {
    -- OBSIDIAN MARKDOWN
    "epwalsh/obsidian.nvim",
    keys = { "<Leader>oo", "<Leader>oc", "<Leader>oa", "<Leader>oA", "<Leader>ot", "<Leader>op", "<Leader>od" },
    cmd = {
      "ObsidianCreate",
      "ObsidianCreateWithDefault",
      "ObsidianDailies",
      "ObsidianToday",
      "ObsidianYesterday",
    },
    ft = "markdown",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      local utils = require("core.utils")

      local function generate_path(spec)
        local path = spec.dir / utils.slugify(spec.title)
        return path:with_suffix(".md")
      end

      -- Obsidian config
      local config_path = vim.fn.expand(obsidian_vault.path .. "/.obsidian/daily-notes.json")
      local config = { daily_notes = utils.read_json(config_path) }

      if not config then
        print("Failed to read daily-notes.json")
      end

      require("obsidian").setup({
        workspaces = { obsidian_vault },
        disable_frontmatter = true,
        templates = {
          folder = "templates",
          substitutions = {
            ["date:ddd, D MMM, YYYY"] = os.date("%a, %d %b, %Y"),
          },
        },
        daily_notes = {
          folder = config.daily_notes.folder,
          template = config.daily_notes.template:match("([^/]+)$"),
        },

        note_path_func = generate_path,
        wiki_link_func = require("obsidian.util").wiki_link_alias_only,
      })

      -- Set up mappings
      require("core.mappings").map_obsidian()
    end,
  },
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
      if vim.fn.isdirectory(home_dir) == 0 then
        utils.sync_repo(home_dir, repo_url)
      end

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
        lang = "c",
      })

      -- Set up commands
      require("core.commands").setup_leetcode_cmds()

      -- Set up autocmds
      require("core.autocmds").leetcode_autocmd(function()
        utils.sync_repo(home_dir, repo_url)
      end)
    end,
  },

  {
    "p00f/godbolt.nvim",
    keys = "<Leader>G",
    cmd = { "Godbolt", "GodboltCompiler" },
    config = function()
      require("godbolt").setup({
        highlight = {
          cursor = "Visual",
          static = false,
        },
      })

      require("core.mappings").map_godbolt()
    end,
  },

  -- Games
  {
    "NStefan002/speedtyper.nvim",
    cmd = "Speedtyper",
    config = function()
      require("speedtyper").setup({})
    end,
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
    config = function()
      require("sudoku").setup({})
    end,
  },
}
