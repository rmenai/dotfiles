return {
  {
    -- TREESITTER
    -- Syntax tree parsing for more intelligent syntax highlighting and code navigation
    -- IMPORTANT: If there are issues try `:TSInstall all` or `:TSUpdate`.
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "asm",
          "bash",
          "c",
          "cmake",
          "dockerfile",
          "json",
          "lua",
          "make",
          "markdown",
          "nasm",
          "python",
          "regex",
          "ruby",
          "rust",
          "toml",
          "vim",
          "vimdoc",
          "yaml",
        },
        highlight = { enable = true },
        rainbow = {
          enable = true,
          extended_mode = true,
          max_file_lines = nil
        }
      })
    end
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function ()
      require("ibl").setup()
    end
  }
}
