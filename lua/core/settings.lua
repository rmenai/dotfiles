-- GLOBAL IDENTATION
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.tabstop = 2

-- UI
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 8
vim.o.mouse = ""
vim.o.signcolumn = "number"
vim.o.showmode = false
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.showtabline = 0
vim.o.termguicolors = true
vim.o.tw = 80
vim.o.wrap = false

-- PERSISTENT UNDO
vim.o.undofile = true
vim.o.undodir = vim.fn.stdpath("data") .. "/undo"

-- LANGUAGES
vim.g.no_ocaml_maps = 1
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
