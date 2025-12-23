local macros = {
  f = "gg]fzRzO$w<leader>uz",
  l = "/@leet<Space>start<CR>jV/@leet<Space>end<CR>k<Space>ygh",
  p = "/struct<Space>Solution<CR>jV/fn<Space>main<CR>kdko<CR><Esc>gh",
}

for reg, cmd in pairs(macros) do
  local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
  vim.fn.setreg(reg, keys)
end
