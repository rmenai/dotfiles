local function map(mode, lhs, rhs, opts)
  opts = opts or { noremap = true, silent = true }
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Remap spliting and resizing windows
map("n", "<Leader>r", "<C-w><C-r>")
map("n", "<Leader>s", "<C-w>s")
map("n", "<Leader>v", "<C-w>v")
map("n", "<Leader>S", ":new<CR>")
map("n", "<Leader>V", ":vnew<CR>")

map("n", "gj", "<C-o>") -- Go prev
map("n", "gk", "<C-i>") -- Go next

map("t", "<Esc>", "<C-\\><C-n>")

-- Delete search highlight
map("n", "<Leader>h", ":noh<CR>")

-- Best remaps
map({ "n", "v" }, "<CR>", ":<up>")
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

map({ "n", "v" }, "<Leader>y", '"+y')
map({ "n", "v" }, "<Leader>Y", '"+Y')

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

-- NVIM-TREE
M.map_nvim_tree = function()
  local nvim_tree = require("nvim-tree.api").tree

  map("n", "<Leader>A", nvim_tree.toggle)
  map("n", "<Leader>a", function()
    nvim_tree.toggle({ find_file = true })
  end)
end

M.map_undotree = function()
  map("n", "<Leader>u", require("undotree").toggle)
end

-- NEOGIT
M.map_neogit = function()
  map("n", "<Leader>N", vim.cmd.CommitCurrentFile)
  map("n", "<Leader>n", function()
    require("neogit").open({ kind = "auto" })
  end)
end

M.map_gitsigns = function()
  local gitsigns = require("gitsigns")
  map("n", "gns", gitsigns.stage_hunk)
  map("n", "gnr", gitsigns.reset_hunk)
  map("v", "gns", function()
    gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
  end)
  map("v", "gnr", function()
    gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
  end)
  map("n", "gnS", gitsigns.stage_buffer)
  map("n", "gnu", gitsigns.undo_stage_hunk)
  map("n", "gnR", gitsigns.reset_buffer)
  map("n", "gnp", gitsigns.preview_hunk)
  map("n", "gnb", function()
    gitsigns.blame_line({ full = true })
  end)
  map("n", "gntb", gitsigns.toggle_current_line_blame)
  map("n", "gnd", gitsigns.diffthis)
  map("n", "gnD", function()
    gitsigns.diffthis("~")
  end)
  map("n", "gntd", gitsigns.toggle_deleted)
end

-- COMPILER
M.map_compiler = function()
  map("n", "<F9>", vim.cmd.CompilerChoose)
  map("n", "<F10>", vim.cmd.CompilerRun)
end

M.map_crates = function()
  local crates = require("crates")

  map("n", "gpt", crates.toggle)
  map("n", "gpr", crates.reload)

  map("n", "gpv", crates.show_versions_popup)
  map("n", "gpf", crates.show_features_popup)
  map("n", "gpd", crates.show_dependencies_popup)

  map("n", "gpu", crates.update_crate)
  map("v", "gpu", crates.update_crates)
  map("n", "gpa", crates.update_all_crates)
  map("n", "gpU", crates.upgrade_crate)
  map("v", "gpU", crates.upgrade_crates)
  map("n", "gpA", crates.upgrade_all_crates)

  map("n", "gpx", crates.expand_plain_crate_to_inline_table)
  map("n", "gpX", crates.extract_crate_into_table)

  map("n", "gpo", crates.open_crates_io)
end

M.map_outline = function()
  map("n", "<Leader>p", require("outline").toggle)
end

M.map_godbolt = function()
  map("n", "<Leader>G", vim.cmd.Godbolt)
end

M.map_hex = function()
  map("n", "<Leader>H", vim.cmd.HexToggle)
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

  map("n", "<F2>", vim.lsp.buf.rename)
  map({ "n", "v", "i" }, "<F3>", vim.lsp.buf.code_action)

  map("n", "gK", vim.diagnostic.goto_prev)
  map("n", "gJ", vim.diagnostic.goto_next)
end

M.map_dap = function()
  local dap = require("dap")

  map("n", "<F5>", dap.continue)
  map("n", "<F6>", dap.step_over)
  map("n", "<F7>", dap.step_into)
  map("n", "<F8>", dap.step_out)
  map("n", "gB", dap.toggle_breakpoint)
end

M.map_formatter = function()
  map("n", "<F4>", function()
    require("conform").format({ lsp_format = "fallback", async = true })
  end)
end

return M
