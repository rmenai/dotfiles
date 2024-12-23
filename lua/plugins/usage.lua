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
    "aserowy/tmux.nvim",
    keys = { "<C-h>", "<C-j>", "<C-k>", "<C-l>", "<A-h>", "<A-j>", "<A-k>", "<A-l>" },
    config = function()
      require("tmux").setup({
        navigation = {
          enable_default_keybindings = true,
          cycle_navigation = false,
          persist_zoom = false,
        },
        resize = {
          enable_default_keybindings = true,
          resize_step_x = 2,
          resize_step_y = 2,
        },
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
    keys = { { "<Leader>?", function() end } },
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
