local function map(mode, lhs, rhs, opts)
  opts = opts or { noremap = true, silent = true }
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Remap spliting and resizing windows
map("n", "<Leader>r", "<C-w><C-r>", { desc = "Rotate window layout" })
map("n", "<Leader>s", "<C-w>s", { desc = "Split window horizontally" })
map("n", "<Leader>v", "<C-w>v", { desc = "Split window vertically" })
map("n", "<Leader>S", ":new<CR>", { desc = "Create new horizontal split" })
map("n", "<Leader>V", ":vnew<CR>", { desc = "Create new vertical split" })

map("n", "gj", "<C-o>", { desc = "Go to previous location" })
map("n", "gk", "<C-i>", { desc = "Go to next location" })

map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Delete search highlight
map("n", "<Leader>h", ":noh<CR>", { desc = "Clear search highlight" })

-- Best remaps
map({ "n", "v" }, "<CR>", ":<up>", { desc = "Repeat last command" })
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })

map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

map({ "n", "v" }, "<Leader>y", '"+y', { desc = "Yank to system clipboard" })
map({ "n", "v" }, "<Leader>Y", '"+Y', { desc = "Yank line to system clipboard" })

-- Use mapping functions for lazy loading
local M = {}

-- TELESCOPE
M.map_telescope = function()
  local telescope = require("telescope.builtin")

  map(
    "n",
    "<Leader><space>",
    require("telescope").extensions.picker_list.picker_list,
    { desc = "Open Telescope picker list" }
  )
  map("n", "<Leader>f", telescope.find_files, { desc = "Find files" })
  map("n", "<Leader>g", telescope.live_grep, { desc = "Search in files" })
  map("n", "<Leader>c", telescope.commands, { desc = "Show commands" })
end

-- NVIM-TREE
M.map_nvim_tree = function()
  local nvim_tree = require("nvim-tree.api").tree

  map("n", "<Leader>A", nvim_tree.toggle, { desc = "Toggle NvimTree" })
  map("n", "<Leader>a", function()
    nvim_tree.toggle({ find_file = true })
  end, { desc = "Toggle NvimTree and find file" })
end

M.map_undotree = function()
  map("n", "<Leader>u", require("undotree").toggle, { desc = "Toggle UndoTree" })
end

-- NEOGIT
M.map_neogit = function()
  map("n", "<Leader>N", vim.cmd.CommitCurrentFile, { desc = "Commit current file" })
  map("n", "<Leader>n", function()
    require("neogit").open({ kind = "auto" })
  end, { desc = "Open Neogit" })
end

M.map_gitsigns = function()
  local gitsigns = require("gitsigns")
  map("n", "gns", gitsigns.stage_hunk, { desc = "Stage hunk" })
  map("n", "gnr", gitsigns.reset_hunk, { desc = "Reset hunk" })
  map("v", "gns", function()
    gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
  end, { desc = "Stage selected hunk" })
  map("v", "gnr", function()
    gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
  end, { desc = "Reset selected hunk" })
  map("n", "gnS", gitsigns.stage_buffer, { desc = "Stage buffer" })
  map("n", "gnu", gitsigns.undo_stage_hunk, { desc = "Undo stage hunk" })
  map("n", "gnR", gitsigns.reset_buffer, { desc = "Reset buffer" })
  map("n", "gnp", gitsigns.preview_hunk, { desc = "Preview hunk" })
  map("n", "gnb", function()
    gitsigns.blame_line({ full = true })
  end, { desc = "Blame current line" })
  map("n", "gntb", gitsigns.toggle_current_line_blame, { desc = "Toggle line blame" })
  map("n", "gnd", gitsigns.diffthis, { desc = "Show diff" })
  map("n", "gnD", function()
    gitsigns.diffthis("~")
  end, { desc = "Show diff against previous commit" })
  map("n", "gntd", gitsigns.toggle_deleted, { desc = "Toggle deleted lines" })
end

-- COMPILER
M.map_compiler = function()
  map("n", "<F9>", vim.cmd.CompilerChoose, { desc = "Choose compiler" })
  map("n", "<F10>", vim.cmd.CompilerRun, { desc = "Run compiler" })
end

M.map_crates = function()
  local crates = require("crates")

  map("n", "gpt", crates.toggle, { desc = "Toggle crate info" })
  map("n", "gpr", crates.reload, { desc = "Reload crate info" })

  map("n", "gpv", crates.show_versions_popup, { desc = "Show crate versions" })
  map("n", "gpf", crates.show_features_popup, { desc = "Show crate features" })
  map("n", "gpd", crates.show_dependencies_popup, { desc = "Show crate dependencies" })

  map("n", "gpu", crates.update_crate, { desc = "Update crate" })
  map("v", "gpu", crates.update_crates, { desc = "Update selected crates" })
  map("n", "gpa", crates.update_all_crates, { desc = "Update all crates" })
  map("n", "gpU", crates.upgrade_crate, { desc = "Upgrade crate" })
  map("v", "gpU", crates.upgrade_crates, { desc = "Upgrade selected crates" })
  map("n", "gpA", crates.upgrade_all_crates, { desc = "Upgrade all crates" })

  map("n", "gpx", crates.expand_plain_crate_to_inline_table, { desc = "Expand crate to inline table" })
  map("n", "gpX", crates.extract_crate_into_table, { desc = "Extract crate into table" })

  map("n", "gpo", crates.open_crates_io, { desc = "Open crates.io" })
end

M.map_outline = function()
  map("n", "<Leader>p", require("outline").toggle, { desc = "Toggle outline" })
end

M.map_godbolt = function()
  map("n", "<Leader>G", vim.cmd.Godbolt, { desc = "Toggle Godbolt" })
end

M.map_hex = function()
  map("n", "<Leader>H", vim.cmd.HexToggle, { desc = "Toggle hex view" })
end

M.map_autosave = function()
  map("n", "<F12>", require("auto-save").toggle, { desc = "Toggle autosave" })
end

-- LSP
M.map_lsp = function()
  map("n", "K", vim.lsp.buf.hover, { desc = "Hover info" })
  map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
  map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
  map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
  map("n", "go", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
  map("n", "gr", vim.lsp.buf.references, { desc = "Show references" })
  map("n", "gs", vim.lsp.buf.signature_help, { desc = "Show signature help" })

  local diagnostics_active = true
  map("n", "<F1>", function()
    diagnostics_active = not diagnostics_active
    if diagnostics_active then
      vim.diagnostic.show()
    else
      vim.diagnostic.hide()
    end
  end, { desc = "Toggle diagnostics" })

  map("n", "<F2>", vim.lsp.buf.rename, { desc = "Rename symbol" })
  map({ "n", "v", "i" }, "<F3>", vim.lsp.buf.code_action, { desc = "Code action" })

  map("n", "gK", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
  map("n", "gJ", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
end

M.map_dap = function()
  local dap = require("dap")

  map("n", "<F5>", dap.continue, { desc = "Start/continue debugging" })
  map("n", "<F6>", dap.step_over, { desc = "Step over" })
  map("n", "<F7>", dap.step_into, { desc = "Step into" })
  map("n", "<F7>", dap.step_into)
  map("n", "<F8>", dap.step_out)
  map("n", "gB", dap.toggle_breakpoint)
end

M.map_formatter = function()
  map("n", "<F4>", function()
    require("conform").format({ lsp_format = "fallback", async = true })
  end)
end

M.map_rust = function()
  map({ "n", "v", "i" }, "<F3>", function()
    vim.cmd.RustLsp("codeAction")
  end)

  map("n", "K", function()
    vim.cmd.RustLsp({ "hover", "actions" })
  end)

  map("n", "gm", function()
    vim.cmd.RustLsp("expandMacro")
  end)

  map("n", "ge", function()
    vim.cmd.RustLsp("renderDiagnostic")
  end)

  map("n", "gE", function()
    vim.cmd.RustLsp({ "explainError", "current" })
  end)

  map("n", "go", function()
    vim.cmd.RustLsp("openDocs")
  end)
end

return M
