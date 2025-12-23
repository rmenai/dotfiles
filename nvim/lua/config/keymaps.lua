local function map(mode, lhs, rhs, opts)
  opts = opts or { noremap = true, silent = true }
  vim.keymap.set(mode, lhs, rhs, opts)
end

map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("n", "gh", ":noh<CR>", { desc = "Clear search highlight" })
map("n", "gh", ":noh<CR>", { desc = "Clear search highlight" })

-- Better yank
map("v", "<leader>yy", '"+y', { desc = "Yank to system clipboard" })
map("n", "<leader>yy", '"+Y', { desc = "Yank line to system clipboard" })
map("n", "<leader>yr", ":let @+=expand('%')<CR>", { desc = "Yank relative path to system clipboard" })
map("n", "<leader>ya", ":let @+=expand('%:p')<CR>", { desc = "Yank absolute path to system clipboard" })
map("n", "<leader>yf", ":let @+=expand('%:t')<CR>", { desc = "Yank filename to system clipboard" })
map("n", "<leader>yd", ":let @+=expand('%:p:h')<CR>", { desc = "Yank directory to system clipboard" })

-- Resize panes
map("n", "<A-h>", function() require("smart-splits").resize_left() end, { desc = "Resize pane left", remap = true })
map("n", "<A-j>", function() require("smart-splits").resize_down() end, { desc = "Resize pane down", remap = true })
map("n", "<A-k>", function() require("smart-splits").resize_up() end, { desc = "Resize pane up", remap = true })
map("n", "<A-l>", function() require("smart-splits").resize_right() end, { desc = "Resize pane right", remap = true })

-- Moving between splits
map({ "n", "v" }, "<C-h>", function() require("smart-splits").move_cursor_left() end, { desc = "Move cursor left", remap = true })
map({ "n", "v" }, "<C-j>", function() require("smart-splits").move_cursor_down() end, { desc = "Move cursor down", remap = true })
map({ "n", "v" }, "<C-k>", function() require("smart-splits").move_cursor_up() end, { desc = "Move cursor up", remap = true })
map({ "n", "v" }, "<C-l>", function() require("smart-splits").move_cursor_right() end, { desc = "Move cursor right", remap = true })
map({ "n", "v" }, "<C-\\>", function() require("smart-splits").move_cursor_previous() end, { desc = "Move cursor to previous split", remap = true })

-- Swapping buffers between windows
map("n", "<leader>wh", function() require("smart-splits").swap_buf_left() end, { desc = "Swap buffer left" })
map("n", "<leader>wl", function() require("smart-splits").swap_buf_right() end, { desc = "Swap buffer up" })
map("n", "<leader>wj", function() require("smart-splits").swap_buf_down() end, { desc = "Swap buffer down" })
map("n", "<leader>wk", function() require("smart-splits").swap_buf_up() end, { desc = "Swap buffer up" })

-- Navigate
map("n", "gj", "<C-o>", { desc = "Go to previous location" })
map("n", "gk", "<C-i>", { desc = "Go to next location" })
