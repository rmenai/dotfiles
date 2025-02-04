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

      -- Add cmp_nvim_lsp capabilities settings to lspconfig
      -- This should be executed before you configure any language server
      lsp_defaults.capabilities = vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

      require("mason-lspconfig").setup({
        handlers = {
          function(server_name) require("lspconfig")[server_name].setup({}) end,
          ["lua_ls"] = function()
            require("lspconfig").lua_ls.setup({
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
            })
          end,
          ["marksman"] = function()
            require("lspconfig").marksman.setup({
              on_attach = function()
                -- Disable diagnostics for marksman
                vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
              end,
            })
          end,
        },
      })

      -- if vim.fn.executable("opam") == 1 then require("lspconfig").ocamllsp.setup({}) end
      require("lspconfig").ocamllsp.setup({})
    end,
  },
}
