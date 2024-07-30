return {
  {
    -- REMEMBER CODE LINE
    "vladdoster/remember.nvim",
    config = function()
      require("remember").setup({})
    end
  },
  {
    -- AUTO CWD
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({
        patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "main.py" }
      })
    end
  }
}
