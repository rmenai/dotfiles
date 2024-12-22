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

-- Best remaps
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("n", "<Leader>h", ":noh<CR>", { desc = "Clear search highlight" })
map({ "n", "v" }, "<Tab>", ":<up>", { desc = "Repeat last command" })
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
map({ "n", "v" }, "<Leader>y", '"+y', { desc = "Yank to system clipboard" })
map({ "n", "v" }, "<Leader>Y", '"+Y', { desc = "Yank line to system clipboard" })

-- TELESCOPE
map("n", "<Leader><space>", function() require("telescope").extensions.picker_list.picker_list() end, { desc = "Open Telescope picker list" })
map("n", "<Leader>f", function() require("telescope.builtin").find_files() end, { desc = "Find files" })
map("n", "<Leader>g", function() require("telescope.builtin").live_grep() end, { desc = "Search in files" })
map("n", "<Leader>c", function() require("telescope.builtin").commands() end, { desc = "Show commands" })

-- INSTALLERS
map("n", "<Leader>l", "<Cmd>Lazy<CR>", { desc = "Open Lazy" })
map("n", "<Leader>m", "<Cmd>Mason<CR>", { desc = "Open Mason" })

-- NVIM-TREE + UNDO
map("n", "<Leader>A", function() require("nvim-tree.api").tree.toggle() end, { desc = "Toggle NvimTree" })
map("n", "<Leader>a", function() require("nvim-tree.api").tree.toggle({ find_file = true }) end, { desc = "Toggle NvimTree and find file" })
map("n", "<Leader>u", function() require("undotree").toggle() end, { desc = "Toggle UndoTree" })

-- GIT
map("n", "<Leader>N", vim.cmd.CommitCurrentFile, { desc = "Commit current file" })
map("n", "<Leader>n", function() require("neogit").open({ kind = "auto" }) end, { desc = "Open Neogit" })
map("n", "gns", function() require("gitsigns").stage_hunk() end, { desc = "Stage hunk" })
map("n", "gnr", function() require("gitsigns").reset_hunk() end, { desc = "Reset hunk" })
map("v", "gns", function() require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Stage selected hunk" })
map("v", "gnr", function() require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Reset selected hunk" })
map("n", "gnS", function() require("gitsigns").stage_buffer() end, { desc = "Stage buffer" })
map("n", "gnu", function() require("gitsigns").undo_stage_hunk() end, { desc = "Undo stage hunk" })
map("n", "gnR", function() require("gitsigns").reset_buffer() end, { desc = "Reset buffer" })
map("n", "gnp", function() require("gitsigns").preview_hunk() end, { desc = "Preview hunk" })
map("n", "gnb", function() require("gitsigns").blame_line({ full = true }) end, { desc = "Blame current line" })
map("n", "gntb", function() require("gitsigns").toggle_current_line_blame() end, { desc = "Toggle line blame" })
map("n", "gnd", function() require("gitsigns").diffthis() end, { desc = "Show diff" })
map("n", "gnD", function() require("gitsigns").diffthis("~") end, { desc = "Show diff against previous commit" })
map("n", "gntd", function() require("gitsigns").toggle_deleted() end, { desc = "Toggle deleted lines" })

-- OUTLINES
map("n", "<Leader>p", function() require("outline").toggle() end, { desc = "Toggle outline" })

-- GODBOLT + HEX
map("n", "<Leader>G", vim.cmd.Godbolt, { desc = "Toggle Godbolt" })
map("n", "<Leader>H", vim.cmd.HexToggle, { desc = "Toggle hex view" })

-- COMPILER + AUTO-SAVE
local autosave_active = false
map("n", "<F9>", vim.cmd.CompilerChoose, { desc = "Choose compiler" })
map("n", "<F10>", vim.cmd.CompilerRun, { desc = "Run compiler" })
map("n", "<F12>", function()
  autosave_active = not autosave_active
  if autosave_active then
    require("auto-save").on()
  else
    require("auto-save").off()
  end
end, { desc = "Toggle autosave" })

-- LSP
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
map("n", "<F4>", function() require("conform").format({ lsp_format = "fallback", async = true }) end, { desc = "Format code" })

map("n", "K", vim.lsp.buf.hover, { desc = "Hover info" })
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
map("n", "go", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
map("n", "gr", vim.lsp.buf.references, { desc = "Show references" })
map("n", "gs", vim.lsp.buf.signature_help, { desc = "Show signature help" })
map("n", "gj", "<C-o>", { desc = "Go to previous location" })
map("n", "gk", "<C-i>", { desc = "Go to next location" })
map("n", "gK", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
map("n", "gJ", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })

-- DAP
map("n", "<F5>", function() require("dap").continue() end, { desc = "Start/continue debugging" })
map("n", "<F6>", function() require("dap").step_over() end, { desc = "Step over" })
map("n", "<F7>", function() require("dap").step_into() end, { desc = "Step into" })
map("n", "<F8>", function() require("dap").step_out() end, { desc = "Step out" })
map("n", "gB", function() require("dap").toggle_breakpoint() end, { desc = "Toggle breakpoint" })

-- RUST
map("n", "gm", function() vim.cmd.RustLsp("expandMacro") end, { desc = "Expand a macro" })
map("n", "ge", function() vim.cmd.RustLsp("renderDiagnostic") end, { desc = "Show diagnostic" })
map("n", "gE", function() vim.cmd.RustLsp({ "explainError", "current" }) end, { desc = "Explain diagnostic" })
map("n", "go", function() vim.cmd.RustLsp("openDocs") end, { desc = "Open cursor documentation" })

-- RUST CRATES
map("n", "gpt", function() require("crates").toggle() end, { desc = "Toggle crate info" })
map("n", "gpr", function() require("crates").reload() end, { desc = "Reload crate info" })
map("n", "gpv", function() require("crates").show_versions_popup() end, { desc = "Show crate versions" })
map("n", "gpf", function() require("crates").show_features_popup() end, { desc = "Show crate features" })
map("n", "gpd", function() require("crates").show_dependencies_popup() end, { desc = "Show crate dependencies" })
map("n", "gpu", function() require("crates").update_crate() end, { desc = "Update crate" })
map("v", "gpu", function() require("crates").update_crates() end, { desc = "Update selected crates" })
map("n", "gpa", function() require("crates").update_all_crates() end, { desc = "Update all crates" })
map("n", "gpU", function() require("crates").upgrade_crate() end, { desc = "Upgrade crate" })
map("v", "gpU", function() require("crates").upgrade_crates() end, { desc = "Upgrade selected crates" })
map("n", "gpA", function() require("crates").upgrade_all_crates() end, { desc = "Upgrade all crates" })
map("n", "gpx", function() require("crates").expand_plain_crate_to_inline_table() end, { desc = "Expand crate to inline table" })
map("n", "gpX", function() require("crates").extract_crate_into_table() end, { desc = "Extract crate into table" })
map("n", "gpo", function() require("crates").open_crates_io() end, { desc = "Open crates.io" })
