local root_patterns = {
  ".git",

  "lua",
  "package.json", -- JS/TS
  "Cargo.toml", -- Rust
  "go.mod", -- Go
  "pyproject.toml", -- Python (Modern)
  "composer.json", -- PHP
  "pom.xml", -- Java/Maven
  "build.gradle", -- Java/Gradle
  "Gemfile", -- Ruby
  "mix.exs", -- Elixir
}

vim.o.clipboard = ""
vim.g.snacks_animate = true
vim.g.root_spec = { "lsp", root_patterns, "cwd" }

vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
