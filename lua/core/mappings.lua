local function map(mode, lhs, rhs, opts)
	opts = opts or { noremap = true, silent = true }
	vim.keymap.set(mode, lhs, rhs, opts)
end

-- Required for mappings to work
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

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

map("n", "gj", "<C-o>") -- Go prev
map("n", "gk", "<C-i>") -- Go next

-- Use mapping functions for lazy loading
local M = {}

-- TELESCOPE
M.map_telescope = function()
	local telescope = require("telescope.builtin")

	map("n", "<Leader><space>", require("telescope").extensions.picker_list.picker_list)
	map("n", "<Leader>f", telescope.find_files)
	map("n", "<Leader>g", telescope.live_grep)
	map("n", "<Leader>c", telescope.commands)
end

-- OBSIDIAN
M.map_obsidian = function()
	map("n", "<Leader>oo", require("core.commands").obsidian_picker)
	map("n", "<Leader>oa", vim.cmd.ObsidianCreate)
	map("n", "<Leader>oA", vim.cmd.ObsidianCreateWithTemplate)
	map("n", "<Leader>ot", vim.cmd.ObsidianTemplate)
	map("n", "<Leader>op", vim.cmd.MarkdownPreview)
	map("n", "<Leader>oc", function()
		vim.cmd.CommitCurrentFile()
		vim.cmd.ObsidianCreate()
	end)
end

-- NVIM-TREE
M.map_nvim_tree = function()
	local nvim_tree = require("nvim-tree.api").tree

	map("n", "<Leader>a", nvim_tree.toggle)
	map("n", "<Leader>A", function()
		nvim_tree.open({ find_file = true })
	end)
end

-- NEOGIT
M.map_neogit = function()
	map("n", "<Leader>nc", vim.cmd.CommitCurrentFile)
	map("n", "<Leader>nn", function()
		require("neogit").open({ kind = "auto" })
	end)
end

-- COMPILER
M.map_compiler = function()
	map("n", "<F9>", vim.cmd.CompilerChoose)
	map("n", "<F10>", vim.cmd.CompilerRun)
	map("v", "<F10>", vim.cmdCompilerRunRange)
end

-- OTHER
M.map_term = function()
	map("n", "<Leader>t", require("toggleterm").toggle)
end

M.map_outline = function()
	map("n", "<Leader>p", require("outline").toggle)
end

-- LSP
M.map_lsp = function()
	map("n", "K", vim.lsp.buf.hover)
	map("n", "gd", vim.lsp.buf.definition)
	map("n", "gD", vim.lsp.buf.declaration)
	map("n", "gi", vim.lsp.buf.implementation)
	map("n", "go", vim.lsp.buf.type_definition)
	map("n", "gr", vim.lsp.buf.references)
	map("n", "gs", vim.lsp.buf.signature_help)

	map("n", "<F1>", vim.lsp.buf.code_action)
	map("n", "<F2>", vim.lsp.buf.rename)

	map("n", "gj", vim.diagnostic.goto_prev)
	map("n", "gk", vim.diagnostic.goto_next)
end

M.map_linter = function()
	map("n", "<F3>", require("lint").try_lint)
end

M.map_formatter = function()
	map("n", "<F4>", function()
		require("conform").format({ lsp_format = "fallback", async = true })
	end)
end

-- DAP
M.map_dap = function()
	local dap = require("dap")

	map("n", "<F5>", dap.continue)
	map("n", "<F6>", dap.repl.toggle)
	map("n", "<F7>", dap.step_into)
	map("n", "<F8>", dap.step_out)
	map("n", "gb", dap.toggle_breakpoint)
	map("n", "gB", dap.set_breakpoint)
end

return M
