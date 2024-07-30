local filetypes = {
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
  "yaml"
}

return {
  {
    -- TREESITTER
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    ft = filetypes,
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = filetypes,
        highlight = { enable = true },
        rainbow = {
          enable = true,
          extended_mode = true,
          max_file_lines = nil
        },
        indent = {
          -- enable = true,
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
