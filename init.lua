-- External Dependencies
-- sudo apt-get install ripgrep fd-find
-- pip install python-lsp-server
-- pip install --user klepto
-- cargo install tree-sitter-cli
-- sudo apt-get -y install ccls
-- apt install python3.12-venv
-- apt unzip
-- sudo apt install tree-sitter-cli
-- apt-get install opam
-- opam init
-- sudo apt install texlive-latex-extra latexmk
-- sioyek

-- Required for mappings to work
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable deprecated warnings
vim.deprecate = function() end

-- Plugins
require("core.lazy")

-- Core setup
require("core.settings")
require("core.commands")
require("core.mappings")

-- Set up clipboard
require("core.autocmds").clipboard_autocmd()
