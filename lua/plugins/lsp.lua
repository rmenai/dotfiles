return {
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v4.x",
    lazy = true,
    config = false,
  },
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup({})
    end,
  },

  -- Autocompletion
  {
    "L3MON4D3/LuaSnip",
    version = "v2.3",
    build = "make install_jsregexp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_lua").load({ paths = "./lua/snippets" })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "L3MON4D3/LuaSnip",
      "onsails/lspkind.nvim",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lua",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-path",
    },
    config = function()
      local luasnip = require("luasnip")
      local cmp = require("cmp")
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")

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

      -- Lazy load tailwind tools
      local function lspkind_format(entry, vim_item)
        return require("tailwind-tools.cmp").lspkind_format(entry, vim_item)
      end

      cmp.setup({
        formatting = {
          fields = { "abbr", "kind", "menu" },
          format = require("lspkind").cmp_format({
            mode = "symbol",
            maxwidth = 50,
            ellipsis_char = "...",

            before = function(entry, vim_item)
              if vim_item.kind == "Color" then
                return lspkind_format(entry, vim_item)
              end

              return vim_item
            end,
          }),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.scroll_docs(-4),
          ["<C-j>"] = cmp.mapping.scroll_docs(4),
          ["<CR>"] = cmp.mapping(confirm_select),
          ["<Tab>"] = cmp.mapping(select_next, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(select_prev, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          { name = "nvim_lua" },
        }, { name = "buffer" }),
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
      })

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
      })

      cmp.setup.cmdline({ ":" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "cmdline" }, { name = "path" } },
      })

      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
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
      lsp_defaults.capabilities =
        vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

      require("mason-lspconfig").setup({
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({})
          end,
          ["lua_ls"] = function()
            require("lspconfig").lua_ls.setup({
              on_init = function(client)
                local path = client.workspace_folders[1].name
                if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
                  return
                end

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
          ["volar"] = function()
            require("lspconfig").volar.setup({
              filetypes = { "typescript", "javascript", "vue" },
              init_options = {
                vue = { hybridMode = false },
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

      -- Set up mappings
      require("core.mappings").map_lsp()
    end,
  },
}
