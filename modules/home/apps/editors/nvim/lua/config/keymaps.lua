local function map(mode, lhs, rhs, opts)
  opts = opts or { noremap = true, silent = true }
  vim.keymap.set(mode, lhs, rhs, opts)
end

map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("n", "gh", ":noh<CR>", { desc = "Clear search highlight" })

-- Better yank
map("v", "<leader>yy", '"+y', { desc = "Yank to system clipboard" })
map("n", "<leader>yy", '"+Y', { desc = "Yank line to system clipboard" })
map("n", "<leader>yr", ":let @+=expand('%')<CR>", { desc = "Yank relative path to system clipboard" })
map("n", "<leader>ya", ":let @+=expand('%:p')<CR>", { desc = "Yank absolute path to system clipboard" })
map("n", "<leader>yf", ":let @+=expand('%:t')<CR>", { desc = "Yank filename to system clipboard" })
map("n", "<leader>yd", ":let @+=expand('%:p:h')<CR>", { desc = "Yank directory to system clipboard" })

-- Move focus
map("n", "<C-h>", "<cmd>NavigateLeftTab<CR>", { desc = "Navigate left or Zellij tab" })
map("n", "<C-j>", "<cmd>NavigateDown<CR>", { desc = "Navigate down" })
map("n", "<C-k>", "<cmd>NavigateUp<CR>", { desc = "Navigate up" })
map("n", "<C-l>", "<cmd>NavigateRightTab<CR>", { desc = "Navigate right or Zellij tab" })

-- Location History
map("n", "gj", "<C-o>", { desc = "Go to previous location" })
map("n", "gk", "<C-i>", { desc = "Go to next location" })
