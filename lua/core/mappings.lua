local function map(mode, lhs, rhs, opts)
  opts = opts or { noremap = true, silent = true }
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Remap spliting and resizing windows
map("n", "<Leader>s", "<C-w>s")
map("n", "<Leader>v", "<C-w>v")
map("n", "<Leader>S", ":new<CR>")
map("n", "<Leader>V", ":vnew<CR>")

map("n", "gj", "<C-o>") -- Go prev
map("n", "gk", "<C-i>") -- Go next

-- Best remaps
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

map("n", "<Leader>y", '"+y')
map("v", "<Leader>y", '"+y')
map("n", "<Leader>Y", '"+Y')

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

M.map_undotree = function()
  map("n", "<Leader>u", require("undotree").toggle)
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
  map("v", "<F10>", vim.cmd.CompilerRunRange)
end

-- OTHER
M.map_term = function()
  map("n", "<Leader>t", require("toggleterm").toggle)
end

M.map_outline = function()
  map("n", "<Leader>p", require("outline").toggle)
end

M.map_autosave = function()
  map("n", "<F12>", require("auto-save").toggle)
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

  local diagnostics_active = true
  map("n", "<F1>", function()
    diagnostics_active = not diagnostics_active
    if diagnostics_active then
      vim.diagnostic.show()
    else
      vim.diagnostic.hide()
    end
  end)

  map({ "n", "v", "i" }, "<F3>", vim.lsp.buf.code_action)
  map("n", "<F2>", vim.lsp.buf.rename)

  map("n", "gJ", vim.diagnostic.goto_prev)
  map("n", "gK", vim.diagnostic.goto_next)
end

M.map_formatter = function()
  map("n", "<F4>", function()
    require("conform").format({ lsp_format = "fallback", async = true })
  end)
end

return M
