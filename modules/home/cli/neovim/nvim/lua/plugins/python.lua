return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local lspconfig = require("lspconfig")
      local configs = require("lspconfig.configs")

      if not configs.ty then
        configs.ty = {
          default_config = {
            cmd = { "ty", "server" },
            root_dir = lspconfig.util.root_pattern("pyproject.toml", "uv.lock", ".git"),
            filetypes = { "python" },
            single_file_support = true,
            settings = {},
          },
        }
      end

      -- The default LazyVim config you pasted tries to enable these.
      opts.servers.pyright = { enabled = false }
      opts.servers.basedpyright = { enabled = false }

      opts.servers.ty = {
        enabled = true,
        settings = {
          ty = {
            -- diagnosticMode = "workspace",
            -- logLevel = "info",
          },
        },
      }

      -- We override the default setup handler to ensure it uses the correct Snacks signature.
      opts.servers.ruff = vim.tbl_deep_extend("force", opts.servers.ruff or {}, {
        enabled = true,
        keys = {
          {
            "<leader>co",
            LazyVim.lsp.action["source.organizeImports"],
            desc = "Organize Imports",
          },
        },
      })

      opts.setup = opts.setup or {}
      opts.setup.ruff = function()
        Snacks.util.lsp.on({ name = "ruff" }, function(_, client)
          -- Disable hover in favor of Ty (instead of Pyright)
          if client.server_capabilities then client.server_capabilities.hoverProvider = false end
        end)
      end
    end,
  },
}
