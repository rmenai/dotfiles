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
        ["<C-e>"] = { "show", "show_documentation", "hide_documentation" },
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
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
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 250,
        },
        ghost_text = {
          enabled = true,
        },
      },

      snippets = { preset = "luasnip" },

      sources = {
        default = { "copilot", "lazydev", "lsp", "path", "snippets", "buffer", "emoji" },
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
            score_offset = 15, -- Tune by preference
            opts = {
              insert = true,
              trigger = function() return { ":" } end,
            },
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
        sorts = {
          "exact",
          "score",
          "sort_text",
        },
      },

      signature = {
        enabled = true,
        window = {
          show_documentation = true,
        },
      },

      cmdline = {
        keymap = {
          ["<Tab>"] = { "show", "accept" },
          ["<Down>"] = { "select_next", "fallback" },
          ["<Up>"] = { "select_prev", "fallback" },
        },
        completion = { menu = { auto_show = true } },
      },
    },
    opts_extend = { "sources.default" },
  },
}
