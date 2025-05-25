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

  {
    "VonHeikemen/lsp-zero.nvim",
    lazy = true,
    config = false,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    cmd = { "LSPStart", "LSPStop", "LSPRestart", "LSPInfo", "LSPLog" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      require("mason-lspconfig").setup({})

      vim.lsp.enable({
        "ocamllsp",
        "nixd",
        "ruff",
        "pyright",
        "bashls",
        "ansiblels",
        "clangd",
        "volar",
        "ts_ls",
        "eslint",
        "html",
        "cssls",
        "lua_ls",
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
}
