local function map(mode, lhs, rhs, opts)
  opts = opts or { noremap = true, silent = true }
  vim.keymap.set(mode, lhs, rhs, opts)
end

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

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
