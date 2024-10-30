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
        integrations = {
          mason = true,
          overseer = true,
        },
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
      local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
        return function(str)
          local win_width = vim.fn.winwidth(0)
          if hide_width and win_width < hide_width then
            return ""
          elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
            return str:sub(1, trunc_len) .. (no_ellipsis and "" or "")
          end
          return str
        end
      end

      local function git()
        local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD 2>/dev/null"):gsub("\n", "")
        return branch ~= "" and " " .. branch or ""
      end

      local filename = require("lualine.components.filename"):extend()
      filename.apply_icon = require("lualine.components.filetype").apply_icon

      require("lsp-progress").setup({})
      require("lualine").setup({
        options = {
          theme = "catppuccin",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { { "mode", fmt = trunc(50, 0, 50) } },
          lualine_b = { { git, fmt = trunc(50, 0, 50) } },
          lualine_c = {
            { filename, symbols = { modified = "●", readonly = "#" } },
            { "diff", fmt = trunc(66, 0, 66) },
            { "diagnostics", fmt = trunc(60, 0, 60) },
          },
          lualine_x = { {
            function()
              return require("lsp-progress").progress()
            end,
            fmt = trunc(60, 0, 60),
          } },
          lualine_y = { { "progress", fmt = trunc(50, 0, 50) } },
          lualine_z = { { "location", fmt = trunc(24, 0, 24) } },
        },
        inactive_sections = {
          lualine_a = { { filename, symbols = { modified = "●", readonly = "#" } } },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { { "location", fmt = trunc(24, 0, 24) } },
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
    keys = { "<Leader>n", "<Leader>N" },
    cmd = { "Neogit" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("neogit").setup({})
      require("core.mappings").map_neogit()
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "VeryLazy" },
    config = function ()
      require("gitsigns").setup({})
    end
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
    cmd = { "ToggleTerm", "ToggleTermSetName" },
    config = function()
      require("toggleterm").setup({})
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
    "RaafatTurki/hex.nvim",
    event = { "VeryLazy" },
    config = function()
      require("hex").setup({})
      require("core.mappings").map_hex()
    end
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
              { "gitsigns", require("core.commands").gitsigns_picker },
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
