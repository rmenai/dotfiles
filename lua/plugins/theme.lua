return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        transparent_background = true
      })
      vim.cmd.colorscheme("catppuccin")
    end
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      {
        "linrongbin16/lsp-progress.nvim",
        config = function()
          require("lsp-progress").setup()
        end
      }
    },
    config = function()
      require("lualine").setup()
    end
  }
}
