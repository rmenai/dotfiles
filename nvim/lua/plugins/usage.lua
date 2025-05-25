return {
  {
    -- AUTO CWD
    "ahmedkhalf/project.nvim",
    lazy = false,
    config = function()
      require("project_nvim").setup({
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true,
        },
        patterns = {
          -- VCS directories
          ".git",
          "_darcs",
          ".hg",
          ".bzr",
          ".svn",

          -- Build files and project-specific files
          "Makefile",
          "CMakeLists.txt",
          "package.json",
          "main.py",
          "dune-project",
          "pom.xml",
          "build.gradle",
          "settings.gradle",
          "cargo.toml",
          "Gemfile",
          "composer.json",
          "setup.py",
          "requirements.txt",
          "pyproject.toml",
          ".env",
          ".editorconfig",
          "tsconfig.json",
          "next.config.js",
          "angular.json",
          "vue.config.js",

          -- Miscellaneous
          "README.md",
          "LICENSE",
          "Dockerfile",
          "docker-compose.yml",
          "Makefile.am",
          "mkconfig",

          -- Data Science / Machine Learning specific
          "environment.yml",
          "requirements-dev.txt",

          -- JavaScript/TypeScript Frameworks
          "webpack.config.js",
          "babel.config.js",

          -- Others
          "Vagrantfile",
          "tslint.json",
          "eslint.json",
          "Rakefile",
          "build.sbt",
        },
      })
    end,
  },
  {
    "mrjones2014/smart-splits.nvim",
    config = function()
      require("smart-splits").setup({
        ignored_buftypes = {
          "nofile",
          "quickfix",
          "prompt",
        },
        ignored_filetypes = { "NvimTree" },
        default_amount = 2,
        -- Desired behavior when your cursor is at an edge and you
        -- are moving towards that same edge:
        -- 'wrap' => Wrap to opposite side
        -- 'split' => Create a new split in the desired direction
        -- 'stop' => Do nothing
        -- function => You handle the behavior yourself
        -- NOTE: If using a function, the function will be called with
        -- a context object with the following fields:
        -- {
        --    mux = {
        --      type:'tmux'|'wezterm'|'kitty'|'zellij'
        --      current_pane_id():number,
        --      is_in_session(): boolean
        --      current_pane_is_zoomed():boolean,
        --      -- following methods return a boolean to indicate success or failure
        --      current_pane_at_edge(direction:'left'|'right'|'up'|'down'):boolean
        --      next_pane(direction:'left'|'right'|'up'|'down'):boolean
        --      resize_pane(direction:'left'|'right'|'up'|'down'):boolean
        --      split_pane(direction:'left'|'right'|'up'|'down',size:number|nil):boolean
        --    },
        --    direction = 'left'|'right'|'up'|'down',
        --    split(), -- utility function to split current Neovim pane in the current direction
        --    wrap(), -- utility function to wrap to opposite Neovim pane
        -- }
        at_edge = "wrap",
        float_win_behavior = "previous",
        move_cursor_same_row = false,
        cursor_follows_swapped_bufs = false,
        ignored_events = {
          "BufEnter",
          "WinEnter",
        },
        disable_multiplexer_nav_when_zoomed = true,
      })
    end,
  },
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      require("notify").setup({
        stages = "static",
        level = "off",
      })

      vim.notify = require("notify")
    end,
  },
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup({
        show_help = false,
        preset = "modern",
        icons = {
          mappings = false,
        },
      })
    end,
  },
  {
    -- AUTO SAVE
    "okuuva/auto-save.nvim",
    cmd = "ASToggle",
    config = function() require("auto-save").setup({ enabled = false }) end,
  },
}
