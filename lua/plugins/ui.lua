return {
  {
    -- THEME
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true,
      })

      -- Set theme
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  {
    -- STATUS BAR
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "linrongbin16/lsp-progress.nvim",
    },
    config = function()
      require("lsp-progress").setup({})
      require("lualine").setup({
        options = {
          globalstatus = true,
          -- ignore_focus = { "NvimTree", "Outline", }
        },
        sections = {
          lualine_c = {
            function()
              return require("lsp-progress").progress()
            end,
            { "filename" },
          },
        },
      })

      -- Set up autocmds
      require("core.autocmds").lualine_autocmd()
    end,
  },
  {
    -- UI IMPROVEMENTS
    "stevearc/dressing.nvim",
    lazy = false,
    config = function()
      require("dressing").setup({})
    end,
  },
  {
    -- DASHBOARD
    "goolord/alpha-nvim",
    lazy = vim.fn.argc() ~= 0,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local theme = require("alpha.themes.startify")
      theme.mru_opts.autocd = true
      require("alpha").setup(theme.config)
    end,
  },

  -- WINDOWS & NAVIGATIONS
  {
    -- FILE SYSTEM TREE
    "nvim-tree/nvim-tree.lua",
    keys = { "<Leader>a", "<Leader>A" },
    cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeClose" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({})

      -- Set up mappings
      require("core.mappings").map_nvim_tree()
    end,
  },
  {
    -- GIT VERSION CONTROL
    "NeogitOrg/neogit",
    keys = { "<Leader>nn", "<Leader>nc" },
    cmd = { "Neogit" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("neogit").setup({})

      -- Set up mappings
      require("core.mappings").map_neogit()
    end,
  },
  {
    -- CODE STRUCTURE VIEW
    "hedyhli/outline.nvim",
    keys = { "<Leader>p" },
    cmd = { "Outline", "OutlineOpen", "OutlineClose", "OutlineStatus" },
    config = function()
      require("outline").setup({})

      -- Set up mappings
      require("core.mappings").map_outline()
    end,
  },
  {
    -- TERMINAL
    "akinsho/toggleterm.nvim",
    keys = { "<Leader>t" },
    cmd = { "ToggleTerm", "ToggleTermSetName" },
    config = function()
      require("toggleterm").setup({
        on_create = function()
          vim.cmd([[ setlocal foldcolumn=1 ]])
        end,
      })

      -- Set up mappings
      require("core.mappings").map_term()
    end,
  },
  {
    "jiaoshijie/undotree",
    keys = { "<Leader>u" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("undotree").setup({
        position = "right",
      })

      -- Set up mappings
      require("core.mappings").map_undotree()
    end,
  },
  {
    -- SEARCH
    "nvim-telescope/telescope.nvim",
    keys = { "<Leader><space>", "<Leader>f", "<Leader>g", "<Leader>c" },
    cmd = { "Telescope" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "OliverChao/telescope-picker-list.nvim",
      "ahmedkhalf/project.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-q>"] = actions.close,
            },
          },
          ignore_case = true,
          smart_case = false,
        },
        extensions = {
          fzf = {
            fuzzy = true,
            case_mode = "ignore_case",
          },
          picker_list = {
            user_pickers = {
              { "obsidian", require("core.commands").obsidian_picker },
              { "leetcode", require("core.commands").leetcode_picker },
              { "compiler", require("core.commands").compiler_picker },
            },
          },
        },
      })

      telescope.load_extension("fzf")
      telescope.load_extension("projects")
      telescope.load_extension("picker_list")

      -- Set up mappings
      require("core.mappings").map_telescope()
    end,
  },
}
