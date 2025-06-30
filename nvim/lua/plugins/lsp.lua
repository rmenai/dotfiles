return {
  {
    -- TREESITTER
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPre",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "vim", "vimdoc" },
        auto_install = true,
        highlight = { enable = true },
        autotag = { enable = true },
        autopairs = { enable = true },
        rainbow = {
          enable = true,
          extended_mode = true,
        },
      })
    end,
  },

  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate", "MasonLog" },
    config = function() require("mason").setup() end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    cmd = { "LSPStart", "LSPStop", "LSPRestart", "LSPInfo", "LSPLog" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      require("mason-lspconfig").setup()

      vim.lsp.enable({
        "ocamllsp",
        "nixd",
        "ruff",
        "pyright",
        "bashls",
        "clangd",
        "volar",
        "ts_ls",
        "eslint",
        "html",
        "cssls",
        "lua_ls",
        "tailwindcss",
        "emmet_ls",
        "texlab",
        "tinymist",
      })
    end,
  },

  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  {
    "chomosuke/typst-preview.nvim",
    ft = "typst",
    version = "1.*",
    opts = {},
  },
}
