local function map(mode, lhs, rhs, opts)
  opts = opts or { noremap = true, silent = true }
  vim.keymap.set(mode, lhs, rhs, opts)
end

map("n", "ge", function() vim.cmd.RustLsp("renderDiagnostic") end, { desc = "Show diagnostic" })
