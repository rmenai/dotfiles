return {
  {
    -- THEME
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({ transparent_background = true })
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
        },
        sections = {
          lualine_c = {
            function()
              return require("lsp-progress").progress()
            end,
          },
        },
      })

      -- Set up autocmds
      require("core.autocmds").lualine_autocmd()
    end,
  },
  {
    -- SHOW SMALL WINBAR
    "b0o/incline.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local utils = require("core.utils")
      local helpers = require("incline.helpers")
      local devicons = require("nvim-web-devicons")

      require("incline").setup({
        window = {
          padding = 0,
          margin = { horizontal = 0, vertical = 0 },
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if filename == "" then
            filename = "[No Name]"
          end

          -- Limit the filename size
          filename = utils.truncate_filename(filename, 20)

          local ft_icon, ft_color = devicons.get_icon_color(filename)
          local modified = vim.bo[props.buf].modified
          local res = {
            ft_icon and {
              " ",
              ft_icon,
              " ",
              guibg = ft_color,
              guifg = helpers.contrast_color(ft_color),
            } or "",
            " ",
            { filename, gui = modified and "bold,italic" or "bold" },
            guibg = "#313244",
          }
          table.insert(res, " ")
          return res
        end,
      })
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
      "nvim-telescope/telescope-dap.nvim",
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
      telescope.load_extension("dap")
      telescope.load_extension("projects")
      telescope.load_extension("picker_list")

      -- Set up mappings
      require("core.mappings").map_telescope()
    end,
  },
}
