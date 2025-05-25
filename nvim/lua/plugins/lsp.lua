return {
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
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason-lspconfig").setup({})

      vim.lsp.enable({
        "ocamllsp",
        "nixd",
        "ruff",
        "bashls",
        "ansiblels",
        "clangd",
        "volar",
        "ts_ls",
        "eslint",
        "html",
        "cssls",
        "lua_ls",
        "pyright",
      })
    end,
  },
}
