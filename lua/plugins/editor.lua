local obsidian_vault = { name = "notes", path = "~/Documents/notes" }

return {
  -- LANGUAGES SUPPORT
  {
    -- LATEX
    "lervag/vimtex",
    ft = { "tex", "plaintex" },
    cmd = { "VimtexInfo", "VimtexCompile", "VimtexStopAll", "VimtexReload" },
    init = function()
      vim.g.vimtex_view_method = "sioyek"
      vim.g.vimtex_view_sioyek_exe = "sioyek.exe"
      vim.g.vimtex_callback_progpath = "wsl nvim"
    end,
  },
  -- -- LANGUAGE SPECIFIC
  -- {
  --   "luckasRanarison/tailwind-tools.nvim",
  --   name = "tailwind-tools",
  --   build = ":UpdateRemotePlugins",
  --   ft = { "html", "css", "vue", "typescript", "javascript" },
  --   cmd = { "TailwindSort", "TailwindColorToggle", "TailwindConcealToggle" },
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --     "nvim-telescope/telescope.nvim",
  --   },
  --   config = function()
  --     require("tailwind-tools").setup({
  --       document_color = {
  --         enabled = true,
  --         kind = "background",
  --         debounce = 0,
  --       },
  --     })
  --   end,
  -- },
  {
    -- OBSIDIAN MARKDOWN
    "epwalsh/obsidian.nvim",
    keys = { "<Leader>oo", "<Leader>oc", "<Leader>oa", "<Leader>oA", "<Leader>ot", "<Leader>op" },
    cmd = {
      "ObsidianCreate",
      "ObsidianCreateWithDefault",
      "ObsidianDailies",
      "ObsidianToday",
      "ObsidianYesterday",
    },
    ft = { "markdown" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local utils = require("core.utils")

      local function generate_path(spec)
        local path = spec.dir / utils.slugify(spec.title)
        return path:with_suffix(".md")
      end

      -- Obsidian config
      local config_path = vim.fn.expand(obsidian_vault.path .. "/.obsidian/daily-notes.json")
      local config = { daily_notes = utils.read_json(config_path) }

      if not config then
        print("Failed to read daily-notes.json")
      end

      require("obsidian").setup({
        workspaces = { obsidian_vault },
        disable_frontmatter = true,
        templates = {
          folder = "templates",
          substitutions = {
            ["date:ddd, D MMM, YYYY"] = os.date("%a, %d %b, %Y"),
          },
        },
        daily_notes = {
          folder = config.daily_notes.folder,
          template = config.daily_notes.template:match("([^/]+)$"),
        },

        note_path_func = generate_path,
        wiki_link_func = require("obsidian.util").wiki_link_alias_only,
      })

      -- Set up mappings
      require("core.mappings").map_obsidian()
    end,
  },
  {
    "kawre/leetcode.nvim",
    lazy = vim.fn.argv()[1] ~= "leet",
    cmd = "Leet",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      local utils = require("core.utils")

      local home_dir = vim.fn.stdpath("data") .. "/leetcode"
      local repo_url = "https://github.com/rmenai/leetcode.git"

      -- Sync repo on start
      if vim.fn.isdirectory(home_dir) == 0 then
        utils.sync_repo(home_dir, repo_url)
      end

      require("leetcode").setup({
        storage = { home = home_dir .. "/solutions" },
        plugins = { non_standalone = true },
        injector = {
          ["c"] = {
            before = {
              "#include <stdlib.h>",
            },
          },
        },
        arg = "leet",
        lang = "c",
      })

      -- Set up commands
      require("core.commands").setup_leetcode_cmds()

      -- Set up autocmds
      require("core.autocmds").leetcode_autocmd(function()
        utils.sync_repo(home_dir, repo_url)
      end)
    end,
  },
  {
    "stevearc/overseer.nvim",
    keys = { "<F9>", "<F10>" },
    cmd = { "OverseerRun", "OverseerToggle" },
    config = function()
      require("overseer").setup({
        templates = { "builtin", "custom" },
        strategy = {
          "toggleterm",
          direction = "horizontal",
          auto_scroll = true,
          close_on_exit = false,
          on_create = function()
            -- Move text by one column
            vim.cmd([[ setlocal foldcolumn=1 ]])
          end,
        },
      })

      -- Set up mappings
      require("core.mappings").map_compiler()
    end,
  },

  {
    -- AUTOMATIC PAIRS
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependencies = { "hrsh7th/nvim-cmp" },
    config = function()
      require("nvim-autopairs").setup({})

      -- Set up cmp
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")

      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
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
    config = function()
      require("Comment").setup({})
    end,
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
