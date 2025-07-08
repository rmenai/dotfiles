local function map(mode, lhs, rhs, opts)
  opts = opts or { noremap = true, silent = true }
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Remap splitting and resizing windows
map("n", "<Leader>r", "<C-w><C-r>", { desc = "Rotate window layout" })
map("n", "<Leader>s", "<C-w>s", { desc = "Split window horizontally" })
map("n", "<Leader>v", "<C-w>v", { desc = "Split window vertically" })
map("n", "<Leader>S", ":new<CR>", { desc = "Create new horizontal split" })
map("n", "<Leader>V", ":vnew<CR>", { desc = "Create new vertical split" })

-- Best remaps
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("n", "gh", ":noh<CR>", { desc = "Clear search highlight" })
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
map("v", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
map("n", "<Leader>yy", '"+Y', { desc = "Yank line to system clipboard" })

-- Paths
map("n", "<Leader>yr", ":let @+=expand('%')<CR>", { desc = "Yank relative path to system clipboard" })
map("n", "<Leader>ya", ":let @+=expand('%:p')<CR>", { desc = "Yank absolute path to system clipboard" })
map("n", "<Leader>yf", ":let @+=expand('%:t')<CR>", { desc = "Yank filename to system clipboard" })
map("n", "<Leader>yd", ":let @+=expand('%:p:h')<CR>", { desc = "Yank directory to system clipboard" })

map({ "n", "v" }, "<A-h>", function() require("smart-splits").resize_left() end, { desc = "Resize pane left" })
map({ "n", "v" }, "<A-j>", function() require("smart-splits").resize_down() end, { desc = "Resize pane down" })
map({ "n", "v" }, "<A-k>", function() require("smart-splits").resize_up() end, { desc = "Resize pane up" })
map({ "n", "v" }, "<A-l>", function() require("smart-splits").resize_right() end, { desc = "Resize pane right" })

-- Moving between splits
map({ "n", "v" }, "<C-h>", function() require("smart-splits").move_cursor_left() end, { desc = "Move cursor left" })
map({ "n", "v" }, "<C-j>", function() require("smart-splits").move_cursor_down() end, { desc = "Move cursor down" })
map({ "n", "v" }, "<C-k>", function() require("smart-splits").move_cursor_up() end, { desc = "Move cursor up" })
map({ "n", "v" }, "<C-l>", function() require("smart-splits").move_cursor_right() end, { desc = "Move cursor right" })
map({ "n", "v" }, "<C-\\>", function() require("smart-splits").move_cursor_previous() end, { desc = "Move cursor to previous split" })

-- Swapping buffers between windows
map("n", "<leader><leader>h", function() require("smart-splits").swap_buf_left() end, { desc = "Swap buffer left" })
map("n", "<leader><leader>j", function() require("smart-splits").swap_buf_down() end, { desc = "Swap buffer down" })
map("n", "<leader><leader>k", function() require("smart-splits").swap_buf_up() end, { desc = "Swap buffer up" })

-- Quickfix
local quickfix_open = false
map("n", "<Leader>q", function()
  quickfix_open = not quickfix_open
  if quickfix_open then
    vim.cmd(":copen")
  else
    vim.cmd(":cclose")
  end
end, { desc = "Toggle quickfix window" })

map("n", "<Leader>n", "<cmd>cnext<CR>zz", { desc = "Forward qlist" })
map("n", "<Leader>N", "<cmd>cprev<CR>zz", { desc = "Backward qlist" })

map("n", "<Leader>k", "<cmd>lnext<CR>zz", { desc = "Forward location list" })
map("n", "<Leader>j", "<cmd>lprev<CR>zz", { desc = "Backward location list" })

-- TELESCOPE
map("n", "<Leader><space>p", function() require("telescope").extensions.picker_list.picker_list() end, { desc = "Open Telescope picker list" })
map("n", "<Leader>f", function() require("telescope.builtin").find_files() end, { desc = "Find files" })
map("n", "<Leader>/", function() require("telescope.builtin").live_grep() end, { desc = "Search in files" })
map("n", "<Leader>c", function() require("telescope.builtin").commands() end, { desc = "Show commands" })

-- INSTALLERS
map("n", "<Leader>l", "<Cmd>Lazy<CR>", { desc = "Open Lazy" })
map("n", "<Leader>m", "<Cmd>Mason<CR>", { desc = "Open Mason" })

-- NVIM-TREE + UNDO
local nvimTreeFocusOrToggle = function()
  local nvimTree = require("nvim-tree.api")
  local currentBuf = vim.api.nvim_get_current_buf()
  local currentBufFt = vim.api.nvim_get_option_value("filetype", { buf = currentBuf })
  if currentBufFt == "NvimTree" then
    nvimTree.tree.toggle({ find_file = true })
  else
    nvimTree.tree.focus({ find_file = true })
  end
end

map("n", "<Leader>A", function() require("nvim-tree.api").tree.toggle() end, { desc = "Toggle NvimTree" })
map("n", "<Leader>a", nvimTreeFocusOrToggle, { desc = "Toggle NvimTree and find file" })
map("n", "<Leader>U", function() require("undotree").toggle() end, { desc = "Toggle UndoTree" })

-- GIT
map("n", "<Leader>Gc", vim.cmd.CommitCurrentFile, { desc = "Commit current file" })

local function is_neogit_open()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.api.nvim_buf_get_option(buf, "filetype") == "NeogitStatus" then return true end
  end
  return false
end

-- toggle Neogit based on whether the status window actually exists
map("n", "<Leader>g", function()
  if is_neogit_open() then
    require("neogit").close()
  else
    require("neogit").open({ kind = "auto" })
  end
end, { desc = "Toggle Neogit" })

map("n", "<Leader>Gs", function() require("gitsigns").stage_hunk() end, { desc = "Stage hunk" })
map("n", "<Leader>Gr", function() require("gitsigns").reset_hunk() end, { desc = "Reset hunk" })
map("v", "<Leader>Gs", function() require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Stage selected hunk" })
map("v", "<Leader>Gr", function() require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Reset selected hunk" })
map("n", "<Leader>GS", function() require("gitsigns").stage_buffer() end, { desc = "Stage buffer" })
-- map("n", "<Leader>Gu", function() require("gitsigns").undo_stage_hunk() end, { desc = "Undo stage hunk" })
map("n", "<Leader>GR", function() require("gitsigns").reset_buffer() end, { desc = "Reset buffer" })
map("n", "<Leader>Gp", function() require("gitsigns").preview_hunk() end, { desc = "Preview hunk" })
map("n", "<Leader>Gb", function() require("gitsigns").blame_line({ full = true }) end, { desc = "Blame current line" })
map("n", "<Leader>Gtb", function() require("gitsigns").toggle_current_line_blame() end, { desc = "Toggle line blame" })
map("n", "<Leader>Gd", function() require("gitsigns").diffthis() end, { desc = "Show diff" })
map("n", "<Leader>GD", function() require("gitsigns").diffthis("~") end, { desc = "Show diff against previous commit" })
map("n", "<Leader>Gtd", function() require("gitsigns").preview_hunk_inline() end, { desc = "Toggle deleted lines" })
map("n", "<Leader>GQ", function() require("gitsigns").setqflist("all") end)
map("n", "<Leader>Gq", require("gitsigns").setqflist)

-- OUTLINES + TERM
map("n", "<Leader>p", function() require("outline").toggle() end, { desc = "Toggle outline" })
map("n", "<Leader>t", "<Cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })

-- GODBOLT + HEX
map("n", "<Leader>h", vim.cmd.HexToggle, { desc = "Toggle hex view" })

-- DB editor
map("n", "<Leader>d", function() require("dbee").toggle() end, { desc = "Open Database editor" })

-- COMPILER + AUTO-SAVE
map("n", "<F9>", vim.cmd.CompilerChoose, { desc = "Choose compiler" })
map("n", "<F10>", vim.cmd.CompilerRun, { desc = "Run compiler" })

-- LSP
map("n", "<F2>", vim.lsp.buf.rename, { desc = "Rename symbol" })
map({ "n", "v", "i" }, "<F3>", function()
  if vim.bo.filetype == "rust" then
    vim.cmd.RustLsp("codeAction")
  else
    vim.lsp.buf.code_action()
  end
end, { desc = "Code action" })
map("n", "<F4>", function() require("conform").format({ lsp_format = "fallback", async = true }) end, { desc = "Format code" })

map("n", "K", function()
  if vim.bo.filetype == "rust" then
    vim.cmd.RustLsp({ "hover", "actions" })
  else
    vim.lsp.buf.hover()
  end
end, { desc = "Hover info" })
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
map("n", "ge", vim.diagnostic.open_float, { desc = "Open diagnostics float" })

-- DAP
map("n", "<F5>", function() require("dap").continue() end, { desc = "Start/continue debugging" })
map("n", "<F6>", function() require("dap").step_over() end, { desc = "Step over" })
map("n", "<F7>", function() require("dap").step_into() end, { desc = "Step into" })
map("n", "<F8>", function() require("dap").step_out() end, { desc = "Step out" })
map("n", "gB", function() require("dap").toggle_breakpoint() end, { desc = "Toggle breakpoint" })

-- RUST
map("n", "gm", function() vim.cmd.RustLsp("expandMacro") end, { desc = "Expand a macro" })
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

-- CopilotChat mappings
map({ "n", "v" }, "<Leader>uu", function() vim.cmd("CopilotChatToggle") end, { desc = "Toggle Copilot Chat" })
map({ "n", "v" }, "<Leader>ul", function() vim.cmd("CopilotChatLoad") end, { desc = "Load Copilot Session" })
map({ "n", "v" }, "<Leader>us", function() vim.cmd("CopilotChatSave") end, { desc = "Save Copilot Session" })
map({ "n", "v" }, "<Leader>uc", function() vim.cmd("CopilotChatReset") end, { desc = "Reset Copilot Chat" })
map({ "n", "v" }, "<Leader>ua", function() vim.cmd("CopilotChatAgents") end, { desc = "Switch Copilot Agent" })
map({ "n", "v" }, "<Leader>um", function() vim.cmd("CopilotChatModels") end, { desc = "Select Copilot Model" })
map({ "n", "v" }, "<Leader>up", function() vim.cmd("CopilotChatPrompts") end, { desc = "List Copilot Prompts" })

map({ "n", "v" }, "<Leader>uf", function() vim.cmd("CopilotChatFix") end, { desc = "Fix with Copilot" })
map({ "n", "v" }, "<Leader>ud", function() vim.cmd("CopilotChatDocs") end, { desc = "Show Copilot Docs" })
map({ "n", "v" }, "<Leader>ug", function() vim.cmd("CopilotChatCommit") end, { desc = "Commit Suggestion" })
map({ "n", "v" }, "<Leader>ue", function() vim.cmd("CopilotChatExplain") end, { desc = "Explain Code with Copilot" })
map({ "n", "v" }, "<Leader>uo", function() vim.cmd("CopilotChatOptimize") end, { desc = "Optimize Prompt with Copilot" })
map({ "n", "v" }, "<Leader>ur", function() vim.cmd("CopilotChatReview") end, { desc = "Review Code with Copilot" })
map({ "n", "v" }, "<Leader>ut", function() vim.cmd("CopilotChatTests") end, { desc = "Generate Tests" })

-- NEOTEST
map("n", "gtr", function() require("neotest").run.run() end, { desc = "Run nearest test" })
map("n", "gtf", function() require("neotest").run.run(vim.fn.expand("%")) end, { desc = "Run tests in current file" })
map("n", "gtd", function() require("neotest").run.run({ strategy = "dap" }) end, { desc = "Debug nearest test" })
map("n", "gts", function() require("neotest").run.stop() end, { desc = "Stop nearest test" })
map("n", "gta", function() require("neotest").run.attach() end, { desc = "Attach to nearest test" })
map("n", "gto", function() require("neotest").output.open({ enter = true }) end, { desc = "Open test output" })
map("n", "gtO", function() require("neotest").output_panel.toggle() end, { desc = "Toggle test output panel" })
map("n", "gtt", function() require("neotest").summary.toggle() end, { desc = "Toggle test summary" })
map("n", "gtw", function() require("neotest").watch.toggle() end, { desc = "Toggle test watch" })

vim.g.blink_cmp = true
vim.g.diagnostics_active = true
vim.g.copilot_enabled = false
vim.g.auto_save = false
vim.g.lsp_active = true

map("n", "<Leader><space>u", function()
  if vim.g.copilot_enabled then
    vim.cmd("Copilot disable")
    vim.g.copilot_enabled = false
    print("Copilot disabled")
  else
    vim.cmd("Copilot enable")
    vim.g.copilot_enabled = true
    print("Copilot enabled")
  end
end, { desc = "Toggle Copilot" })

map("n", "<Leader><space>c", function()
  vim.g.blink_cmp = not vim.g.blink_cmp
  local status = vim.g.blink_cmp and "enabled" or "disabled"
  print("Blink.cmp " .. status)
end, { desc = "Toggle Blink.cmp" })

map("n", "<Leader><space>d", function()
  vim.g.diagnostics_active = not vim.g.diagnostics_active
  if vim.g.diagnostics_active then
    vim.diagnostic.show()
    print("Diagnostics enabled")
  else
    vim.diagnostic.hide()
    print("Diagnostics disabled")
  end
end, { desc = "Toggle diagnostics" })

map("n", "<Leader><space>s", function()
  vim.g.auto_save = not vim.g.auto_save
  if vim.g.auto_save then
    require("auto-save").on()
    print("Autosave enabled")
  else
    require("auto-save").off()
    print("Autosave disabled")
  end
end, { desc = "Toggle autosave" })

map("n", "<Leader><space>l", function()
  vim.g.lsp_active = not vim.g.lsp_active
  if vim.g.lsp_active then
    vim.cmd("LspStart")
    print("LSP enabled")
  else
    vim.cmd("LspStop")
    print("LSP disabled")
  end
end, { desc = "Toggle LSP" })

map("n", "<Leader><space>t", function() vim.cmd("TailwindConcealToggle") end, { desc = "Toggle LSP" })
map("n", "<Leader><space>f", function() vim.cmd("FormatToggle") end, { desc = "Toggle Format" })
