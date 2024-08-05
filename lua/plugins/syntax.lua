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
  "yaml",
  "dap_repl"
}

return {
  { },
  {
    -- TREESITTER
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    ft = filetypes,
    dependencies = { "LiadOz/nvim-dap-repl-highlights" },
    config = function()
      -- Initialize dap plugins
      require("nvim-dap-repl-highlights").setup()

      require("nvim-treesitter.configs").setup({
        ensure_installed = filetypes,
        highlight = { enable = true },
        rainbow = {
          enable = true,
          extended_mode = true,
          max_file_lines = nil
        },
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
