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
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local lsp_defaults = require("lspconfig").util.default_config
      local lspconfig = require("lspconfig")

      -- Add cmp_nvim_lsp capabilities settings to lspconfig
      -- This should be executed before you configure any language server
      lsp_defaults.capabilities = vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())
      require("mason-lspconfig").setup({})

      local servers = {
        {
          lspconfig_name = "ocamllsp",
          mason_pkg = "ocaml-lsp",
          binary = "ocamllsp",
          config = {},
        },
        {
          lspconfig_name = "nixd",
          mason_pkg = "nil",
          binary = "nixd",
          config = {},
        },
        {
          lspconfig_name = "pyright",
          mason_pkg = "pyright",
          binary = "pyright",
          config = {},
        },
        {
          lspconfig_name = "rust_analyzer",
          mason_pkg = "rust-analyzer",
          binary = "rust-analyzer",
          config = {},
        },
        {
          lspconfig_name = "bashls",
          mason_pkg = "bash-language-server",
          binary = "bash-language-server",
          config = {},
        },
        {
          lspconfig_name = "clangd",
          mason_pkg = "clangd",
          binary = "clangd",
          config = {},
        },
        {
          lspconfig_name = "lua_ls",
          mason_pkg = "lua-language-server",
          binary = "lua-language-server",
          config = {
            on_init = function(client)
              local path = client.workspace_folders[1].name
              if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then return end

              client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                runtime = {
                  version = "LuaJIT",
                },
                workspace = {
                  checkThirdParty = false,
                  library = vim.env.VIMRUNTIME,
                },
              })
            end,
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                },
              },
            },
          },
        },
      }

      -- Loop over the list and initialize each available LSP
      for _, server in ipairs(servers) do
        if require("core.utils").is_server_available(server.mason_pkg, server.binary) then lspconfig[server.lspconfig_name].setup(server.config) end
      end
    end,
  },
}
