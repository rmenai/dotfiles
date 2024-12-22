local function map(mode, lhs, rhs, opts)
  opts = opts or { noremap = true, silent = true }
  vim.keymap.set(mode, lhs, rhs, opts)
end

map({ "n", "v", "i" }, "<F3>", function() vim.cmd.RustLsp("codeAction") end, { desc = "Trigger code action" })
map("n", "K", function() vim.cmd.RustLsp({ "hover", "actions" }) end, { desc = "Show hover documentation" })
