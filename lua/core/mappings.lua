local commands = require("core.commands")
local dap = require("dap")
local nvim_tree = require("nvim-tree.api").tree
local telescope = require("telescope.builtin")
local telescope_extensions = require("telescope").extensions

local function map(mode, lhs, rhs, opts)
  opts = opts or { noremap = true, silent = true }
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Remap window navigation using the navigation button
map("n", "<Leader>j", "<C-w>j")
map("n", "<Leader>k", "<C-w>k")
map("n", "<Leader>h", "<C-w>h")
map("n", "<Leader>l", "<C-w>l")
map("n", "<Leader>w", "<C-w>w")
map("n", "<Leader>W", "<C-w>W")
map("n", "<Leader>x", "<C-w>x")
map("n", "<Leader>K", "<C-w>K")
map("n", "<Leader>J", "<C-w>J")
map("n", "<Leader>H", "<C-w>H")
map("n", "<Leader>L", "<C-w>L")
map("n", "<Leader>T", "<C-w>T")

-- Remap spliting and resizing windows
map("n", "<Leader>s", "<C-w>s")
map("n", "<Leader>v", "<C-w>v")
map("n", "<Leader>S", ":new<CR>")
map("n", "<Leader>V", ":vnew<CR>")
map("n", "<Leader>=", "<C-w>=")
map("n", "<Leader>[", "<C-w>+")
map("n", "<Leader>]", "<C-w>-")
map("n", "<Leader>.", "<C-w>>")
map("n", "<Leader>,", "<C-w><")
map("n", "<Leader>|", "<C-w>|")


-- TELESCOPE
map("n", "<Leader><space>", telescope_extensions.picker_list.picker_list)
map("n", "<Leader>f", telescope.find_files)
map("n", "<Leader>g", telescope.live_grep)
map("n", "<Leader>c", telescope.commands)

-- OBSIDIAN
map("n", "<Leader>oo", telescope.obsidian)
map("n", "<Leader>oc", "<cmd>CommitCurrentFile<CR><cmd>ObsidianCreate<CR>")
map("n", "<Leader>oa", "<cmd>ObsidianCreate<CR>")
map("n", "<Leader>oA", "<cmd>ObsidianCreateWithTemplate<CR>")
map("n", "<Leader>ot", "<cmd>ObsidianTemplate<CR>")
map("n", "<Leader>op", "<cmd>MarkdownPreview<CR>")

-- NVIM-TREE
map("n", "<Leader>a", nvim_tree.toggle)
map("n", "<Leader>A", function() nvim_tree.open({ find_file = true }) end)

-- NEOGIT
map("n", "<Leader>nn", "<cmd>Neogit kind=auto<CR>")
map("n", "<Leader>nc", "<cmd>CommitCurrentFile<CR>")

-- COMPILER
map("n", "<F9>", "<cmd>CompilerChoose<CR>")
map("n", "<F10>", "<cmd>CompilerRun<CR>")
map("v", "<F10>", "<cmd>CompilerRunRange<CR>")

-- OTHER
map("n", "<Leader>t", "<cmd>ToggleTerm<CR>")
map("n", "<Leader>p", "<cmd>Outline<CR>")


-- LSP
map("n", "K", vim.lsp.buf.hover)
map("n", "gd", vim.lsp.buf.definition)
map("n", "gD", vim.lsp.buf.declaration)
map("n", "gi", vim.lsp.buf.implementation)
map("n", "go", vim.lsp.buf.type_definition)
map("n", "gr", vim.lsp.buf.references)
map("n", "gs", vim.lsp.buf.signature_help)
map("n", "gj", "<C-o>") -- Go prev
map("n", "gk", "<C-i>") -- Go next 

map("n", "<F2>", vim.lsp.buf.rename)
map("n", "<F3>", vim.lsp.buf.format)
map("n", "<F4>", vim.lsp.buf.code_action)

-- DAP
map("n", "<F5>", dap.continue)
map("n", "<F6>", dap.repl.toggle)
map("n", "<F7>", dap.step_into)
map("n", "<F8>", dap.step_out)
map("n", "gb", dap.toggle_breakpoint)
map("n", "gB", dap.set_breakpoint)

-- DIAGNOSTICS
map("n", "gj", vim.diagnostic.goto_prev)
map("n", "gk", vim.diagnostic.goto_next)

-- CODE EDITING
-- gc, gcc
