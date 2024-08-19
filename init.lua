-- External Dependencies
-- sudo apt-get install ripgrep fd-find
-- pip install python-lsp-server
-- pip install --user klepto
-- cargo install tree-sitter-cli
-- sioyek

-- Plugins
require("core.lazy")

-- Core setup
require("core.settings")
require("core.commands")
require("core.mappings")

-- Set up clipboard
require("core.autocmds").clipboard_autocmd()
