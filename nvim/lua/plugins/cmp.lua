return {
  -- Autocompletion
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = "./lua/snippets" })
    end,
  },

  {
    "saghen/blink.cmp",
    dependencies = {
      "fang2hou/blink-copilot",
      "moyiz/blink-emoji.nvim",
    },
    version = "1.*",
    opts = {
      enabled = function() return vim.g.blink_cmp ~= false end,

      keymap = {
        preset = "enter",
        ["<A-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide" },
        ["<C-S-K>"] = { "show_signature", "hide_signature", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.snippet_forward()
            else
              return cmp.select_next()
            end
          end,
          "fallback",
        },
        ["<S-Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.snippet_backward()
            else
              return cmp.select_prev()
            end
          end,
          "fallback",
        },
        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
      },

      appearance = {
        nerd_font_variant = "mono",
      },

      completion = {
        menu = {
          auto_show = true,
        },
        list = {
          selection = {
            preselect = false,
            auto_insert = false,
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
        },
        ghost_text = {
          enabled = true,
          show_with_menu = false,
        },
      },

      snippets = { preset = "luasnip" },

      sources = {
        default = { "copilot", "lsp", "lazydev", "snippets", "path", "buffer", "emoji" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            score_offset = 100,
            async = true,
          },
          emoji = {
            module = "blink-emoji",
            name = "Emoji",
            score_offset = 4,
            opts = {
              insert = true,
              trigger = function() return { ":" } end,
            },
          },
          buffer = {
            score_offset = -8,
          },
          path = {
            opts = {
              get_cwd = function(_) return vim.fn.getcwd() end,
            },
          },
        },
      },

      fuzzy = {
        implementation = "prefer_rust",
      },

      signature = {
        enabled = false,
        window = {
          show_documentation = true,
        },
      },

      cmdline = {
        keymap = { preset = "inherit" },
        completion = {
          menu = { auto_show = true },
          list = {
            selection = {
              preselect = false,
              auto_insert = false,
            },
          },
        },
      },
    },
    opts_extend = { "sources.default" },
  },
}
