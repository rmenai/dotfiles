local obsidian_vault = { name = "notes", path = "~/Documents/Vaults/notes" }

return {
  -- LANGUAGES SUPPORT
  {
    -- LATEX
    "lervag/vimtex",
    ft = { "tex", "plaintex" },
    cmd = { "VimtexInfo" },
    init = function()
      vim.g.vimtex_view_method = "sioyek"
      vim.g.vimtex_view_sioyek_exe ="sioyek.exe"
      vim.g.vimtex_callback_progpath = "wsl nvim"
    end
  },
  {
    -- MARKDOWN PREVIEW
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
    init = function ()
      vim.g.mkdp_auto_start = 0
    end
  },
  {
    -- OBSIDIAN MARKDOWN
    "epwalsh/obsidian.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cond = function()
      local vault_path = vim.fn.expand(obsidian_vault.path)
      local cwd = vim.fn.getcwd()

      -- Check whenever the cwd is inside the vault cwd
      return cwd:sub(1, #vault_path) == vault_path
    end,
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
            ["date:ddd, D MMM, YYYY"] = os.date("%a, %d %b, %Y")
          }
        },
        daily_notes = {
          folder = config.daily_notes.folder,
          template = config.daily_notes.template:match("([^/]+)$")
        },

        note_path_func = generate_path,
        wiki_link_func = require("obsidian.util").wiki_link_path_prefix,
      })
    end
  },
  {
    "stevearc/overseer.nvim",
    cmd = "OverseerRun",
    config  = function()
      require("overseer").setup({
        templates = { "builtin", "custom" },
        strategy = {
          "toggleterm",
          direction = "horizontal",
          auto_scroll = true,
          on_create = function ()
            -- Move text by one column
            vim.cmd([[ setlocal foldcolumn=1 ]])
          end
        },
      })
    end
  },
  {
    "michaelb/sniprun",
    branch = "master",
    build = "sh install.sh",
    cmd = "SnipRun",
    config = function()
      require("sniprun").setup({
        repl_enable = {
          "Python3_original", "Bash_original", "Lua_nvim",
          "OCaml_fifo"
        }
      })
    end,
  },
  {
    -- CMAKE
    "Civitasv/cmake-tools.nvim",
    cmd =  { "CMakeGenerate", "CMakeBuild", "CMakeClean", "CMakeRun" },
    config = function ()
      require("cmake-tools").setup({
        cmake_virtual_text_support = false,
        cmake_runner = {
          name = "overseer",
          opts = {
            new_task_opts = {
              strategy = {
                "toggleterm",
                direction = "horizontal",
                auto_scroll = true,
                quit_on_exit = "never",
                on_create = function ()
                  -- Move text by one column
                  vim.cmd([[ setlocal foldcolumn=1 ]])
                end
              }
            }
          }
        },
      })
    end
  },

  {
    -- GITHUB COPILOT INTEGRATION
    "CopilotC-Nvim/CopilotChat.nvim",
    cmd = { "Copilot", "CopilotChat" },
    dependencies = {
      "zbirenbaum/copilot.lua",
      "nvim-lua/plenary.nvim"
    },
    config = function()
      require("CopilotChat").setup({})
    end
  },

  {
    -- AUTOMATIC PAIRS
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true
  },
  {
    -- EASIER COMMENTING
    "terrortylor/nvim-comment",
    keys = { "gc", "gcc", "gbc" },
    config = function()
      require("nvim_comment").setup({})
    end
  },
  {
    -- AUTO IDENTING
    "nmac427/guess-indent.nvim",
    event = "BufReadPost",
    config = function ()
      require("guess-indent").setup({})
    end
  },
  {
    -- COLOR PREVIEW
    "norcalli/nvim-colorizer.lua",
    ft = { "css", "html", "javascript", "typescript", "lua" },
    config = function ()
      require("colorizer").setup()
    end
  },
  {
    -- BETTER ESCAPE INSERT
    "TheBlob42/houdini.nvim",
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
        }
      })
    end
  }
}
