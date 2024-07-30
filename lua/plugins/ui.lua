return {
  {
    -- THEME
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({ transparent_background = true })
      vim.cmd.colorscheme("catppuccin")
    end
  },
  {
    -- ICONS
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({})
    end
  },
  {
    -- PROGRESS BAR
    "linrongbin16/lsp-progress.nvim",
    event = "VeryLazy",
    config = function()
      require("lsp-progress").setup({})
    end
  },
  {
    -- STATUS BAR
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "linrongbin16/lsp-progress.nvim"
    },
    config = function()
      require("lualine").setup({
        options = {
          globalstatus = true
        }
      })
    end
  },
  {
    -- SHOW SMALL WINBAR
    "b0o/incline.nvim",
    config = function()
      local helpers = require("incline.helpers")
      local devicons = require("nvim-web-devicons")
      require("incline").setup {
        window = {
          padding = 0,
          margin = { horizontal = 0, vertical = 0 },
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if filename == "" then
            filename = "[No Name]"
          end
          local ft_icon, ft_color = devicons.get_icon_color(filename)
          local modified = vim.bo[props.buf].modified
          local res = {
            ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
            " ",
            { filename, gui = modified and "bold,italic" or "bold" },
            guibg = "#313244",
          }
          table.insert(res, " ")
          return res
        end,
      }
    end,
  },
  {
    -- UI IMPROVEMENTS
    "stevearc/dressing.nvim",
    config = function()
      require("dressing").setup({})
    end
  },
  {
    -- DASHBOARD
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cond = function()
      return vim.fn.argc() == 0
    end,
    config = function()
      local theme = require("alpha.themes.startify")
      theme.mru_opts.autocd = true
      require("alpha").setup(theme.config)
    end
  },

  -- WINDOWS & NAVIGATION
  {
    -- SPEED UP TELESCOPE
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    event = "VeryLazy"
  },
  {
    -- ESSENTIAL COMMANDS
    "nvim-lua/plenary.nvim",
    event = "VeryLazy"
  },
  {
    -- FILE SYSTEM TREE
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "NvimTreeFindFile", "NvimTree" },
    config = function()
      require("nvim-tree").setup({})

      -- Define custom command for nvim-tree function
      vim.api.nvim_create_user_command("NvimTree", function()
        vim.cmd("NvimTreeToggle")
      end ,{})
    end
  },
  {
    -- SEARCH
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    cmd = "Telescope",
    config = function()
      local telescope = require("telescope")

      telescope.load_extension("fzf")
      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
              ["<C-q>"] = "close",
              ["<C-n>"] = "preview_scrolling_down",
              ["<C-m>"] = "preview_scrolling_up",
            }
          }
        }
      })
    end
  },
  {
    -- GIT VERSION CONTROL
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim"
    },
    cmd = "Neogit",
    config = function()
      require("neogit").setup({
        mappings = {
          popup = {
            ["?"] = false -- Disabling the help menu because it causes an error
          }
        }
      })
    end
  },
  {
    -- CODE STRUCTURE VIEW
    "hedyhli/outline.nvim",
    cmd = "Outline",
    config = function()
      require("outline").setup({})
    end
  },
  {
    -- LARGE CODE VIEW
    "gorbit99/codewindow.nvim",
    cmd = "Codewindow",
    config = function()
      local codewindow = require("codewindow")
      codewindow.setup()

      -- Define custom command for codewindow function
      vim.api.nvim_create_user_command("Codewindow", function()
        codewindow.toggle_minimap()
      end ,{})
    end
  },
  {
    -- TERMINAL
    "akinsho/toggleterm.nvim",
    cmd = "ToggleTerm",
    config = function ()
      require("toggleterm").setup({
        on_create = function()
          -- Move text my one column
          vim.cmd([[ setlocal foldcolumn=1 ]])
        end,
      })
    end
  }
}
