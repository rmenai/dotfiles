local lsp_servers = {
  asm = "asm_lsp",
  sh = "bashls",
  c = "clangd",
  cpp = "clangd",
  json = "jsonls",
  lua = "lua_ls",
  markdown = "marksman",
  cmake = "neocmake",
  python = "pylsp",
  tex = "texlab",
  yaml = "yamlls",
}

local filetypes = {}
local servers = {}

for filetype, server in pairs(lsp_servers) do
  table.insert(filetypes, filetype)
  table.insert(servers, server)
end

return {
  {
    "VonHeikemen/lsp-zero.nvim",
    ft = filetypes,
    init = function()
      -- Disable automatic setup, we are doing it manually
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    config = true,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = { "L3MON4D3/LuaSnip" },
    config = function()
      local lsp_zero = require("lsp-zero")
      lsp_zero.extend_cmp()

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      local function select_next(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.locally_jumpable(1) then
          luasnip.jump(1)
        else
          fallback()
        end
      end

      local function select_prev(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end

      local function confirm_select(fallback)
        if cmp.visible() then
          if luasnip.expandable() then
            luasnip.expand()
          else
            cmp.confirm({ select = true })
          end
        else
          fallback()
        end
      end

      cmp.setup({
        formatting = lsp_zero.cmp_format({details = true}),
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.scroll_docs(-4),
          ["<C-j>"] = cmp.mapping.scroll_docs(4),
          ["<CR>"] = cmp.mapping(confirm_select),
          ["<Tab>"] = cmp.mapping(select_next, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(select_prev, { "i", "s" })
        }),
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
      })
    end
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    ft = filetypes,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- This is where all the LSP shenanigans will live
      local lsp_zero = require("lsp-zero")
      lsp_zero.extend_lspconfig()

      lsp_zero.on_attach(function(client, bufnr)
        lsp_zero.default_keymaps({buffer = bufnr})
      end)

      require("mason-lspconfig").setup({
        ensure_installed = servers,
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({})
          end,
          ["lua_ls"] = function()
            require("lspconfig").lua_ls.setup({
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { "vim" },
                  },

                  workspace = {
                    library = {
                      [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                      [vim.fn.stdpath("config") .. "/lua"] = true,
                    }
                  }
                }
              }
            })
          end,
          ["marksman"] = function()
            require("lspconfig").marksman.setup({
              on_attach = function(client, bufnr)
                -- Disable diagnostics for marksman
                vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
              end
            })
          end
        }
      })
    end
  }
}
