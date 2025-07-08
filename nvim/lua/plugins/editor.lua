return {
  -- LANGUAGES SUPPORT
  {
    -- LATEX
    "lervag/vimtex",
    ft = { "tex", "plaintex" },
    cmd = { "VimtexInfo", "VimtexCompile", "VimtexStopAll", "VimtexReload" },
    init = function()
      vim.g.vimtex_view_method = "zathura"
      -- vim.g.vimtex_view_sioyek_exe = "sioyek.exe"
      -- vim.g.vimtex_callback_progpath = "wsl nvim"
    end,
  },
  -- LANGUAGE SPECIFIC
  {
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    build = ":UpdateRemotePlugins",
    ft = { "html", "css", "vue", "typescript", "javascript" },
    cmd = { "TailwindSort", "TailwindColorToggle", "TailwindConcealToggle" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("tailwind-tools").setup({
        document_color = {
          enabled = true,
          kind = "inline",
          debounce = 0,
        },
        conceal = {
          enabled = true,
          symbol = "…",
          highlight = {
            fg = "#a6d189",
          },
        },
      })
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    ft = "rust",
    config = function()
      local executors = require("rustaceanvim.executors")

      require("core.patches").patch_toggleterm()

      vim.g.rustaceanvim = {
        tools = {
          executor = executors.toggleterm,
          test_executor = executors.neotest,
          crate_test_executor = executors.toggleterm,
        },
        server = {
          default_settings = {
            ["rust-analyzer"] = {
              completion = {
                capable = {
                  snippets = "add_parenthesis",
                },
              },
            },
          },
        },
      }

      require("core.patches").patch_runnables()
    end,
  },
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    config = function()
      require("crates").setup({
        completion = {
          crates = {
            enabled = true,
            max_results = 8,
            min_chars = 3,
          },
        },
        lsp = {
          enabled = true,
          actions = true,
          completion = true,
          hover = true,
        },
      })
    end,
  },
  {
    "kndndrj/nvim-dbee",
    dependencies = { "MunifTanjim/nui.nvim" },
    cmd = { "Dbee" },
    build = function() require("dbee").install() end,
    config = function() require("dbee").setup() end,
  },
  {
    "stevearc/overseer.nvim",
    cmd = { "OverseerRun", "OverseerToggle" },
    config = function()
      require("overseer").setup({
        templates = { "builtin", "custom" },
        dap = false,
        strategy = {
          "toggleterm",
          direction = "horizontal",
          auto_scroll = true,
          close_on_exit = false,
        },
      })
    end,
  },

  {
    -- AUTOMATIC PAIRS
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local Rule = require("nvim-autopairs.rule")
      local npairs = require("nvim-autopairs")
      local cond = require("nvim-autopairs.conds")

      npairs.setup({})
      npairs.get_rules("'")[1].not_filetypes = { "scheme", "lisp", "ocaml" }
      npairs.add_rule(Rule("'", "'"):with_pair(cond.not_filetypes({ "ocaml" })))
      npairs.add_rule(Rule("$", "$", { "tex", "latex", "typ", "typst" }):with_pair())
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "css", "vue", "javascript", "typescript", "markdown" },
    config = function()
      require("nvim-ts-autotag").setup({
        opts = {
          enable_close_on_slash = true,
        },
      })
    end,
  },
  {
    "numToStr/Comment.nvim",
    event = "BufRead",
    config = function() require("Comment").setup({}) end,
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function() require("nvim-surround").setup({}) end,
  },
  {
    -- COLOR PREVIEW
    "norcalli/nvim-colorizer.lua",
    ft = { "css", "html", "javascript", "typescript", "vue", "json" },
    cmd = { "ColorizerToggle", "ColorizerDetachFromBuffer" },
    config = function()
      require("colorizer").setup({
        "*",
        user_default_options = {
          RGB = true,
          RRGGBB = true,
          RRGGBBAA = true,
          names = true,
          rgb_fn = true,
          hsl_fn = true,
          css = true,
          css_fn = true,
        },
      })
    end,
  },
  {
    "chrisgrieser/nvim-recorder",
    dependencies = "rcarriga/nvim-notify",
    keys = {
      { "q", desc = "Start Recording" },
      { "Q", desc = "Play Recording" },
    },
    config = function()
      require("recorder").setup({
        slots = { "q" },
        mapping = {
          startStopRecording = "Q",
          playMacro = "@q",
          yankMacro = "yq",
        },
      })
    end,
  },
  {
    -- BETTER ESCAPE INSERT
    "TheBlob42/houdini.nvim",
    event = "ModeChanged",
    config = function()
      require("houdini").setup({
        mappings = { "jj", "jk" },
        timeout = 200,
        escape_sequences = {
          ["v"] = false,
          ["vs"] = false,
          ["V"] = false,
          ["Vs"] = false,
          ["no"] = false,
          ["nov"] = false,
          ["noV"] = false,
        },
      })
    end,
  },
}
