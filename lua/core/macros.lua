local macros = {
  c = "ggV/type PreCalc<Enter>zf/TestType<Enter>VjzfjjVGzf/fn solve<Enter><Leader>hj^",
  l = "/@leet<Space>start<CR>jV/@leet<Space>end<CR>k<Space>y",
  p = "/struct<Space>Solution<CR>jV/fn<Space>main<CR>kdko<CR><Esc><Space>h",
}

for reg, cmd in pairs(macros) do
  local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
  vim.fn.setreg(reg, keys)
end
