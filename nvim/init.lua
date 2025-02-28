-- Required for mappings to work
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- cargo install --git https://github.com/yunusey/codeforces-extractor

-- Disable deprecated warnings
vim.deprecate = function() end

-- Plugins
require("core.lazy")

-- Core setup
require("core.settings")
require("core.commands")
require("core.mappings")
require("core.macros")
require("core.autocmds")
