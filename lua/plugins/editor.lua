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
    config = function()
      local function slugify(title)
        local slug = title:lower()

        slug = slug:gsub("[^%w%s%-]", "")
        slug = slug:gsub("%s+", "-")
        slug = slug:gsub("-+", "-")
        return slug
      end

      local function generate_path(spec)
        local path = spec.dir / slugify(spec.title)
        return path:with_suffix(".md")
      end

      local function generate_frontmatter(note)
        local date = os.date("%Y-%m-%d %H:%M")
        local out = { title = note.title, date = date, tags = note.tags }

        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end

        return out
      end

      require("obsidian").setup({
        workspaces = {
          {
            name = "notes",
            path = "~/Documents/Vaults/notes"
          }
        },
        daily_notes = {
          folder = "dailies"
        },
        note_path_func = generate_path,
        wiki_link_func = require("obsidian.util").wiki_link_path_prefix,
        note_frontmatter_func = generate_frontmatter
      })
    end
  },
  {
    "stevearc/overseer.nvim",
    cmd = "OverseerRun",
    config  = function()
      require("overseer").setup({
        templates = { "builtin", "languages" },
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
    event = "BufReadPost",
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
