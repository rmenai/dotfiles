local M = {}

-- Listen lsp-progress event and refresh lualine
M.lualine_autocmd = function()
  vim.api.nvim_create_autocmd("User", {
    group = vim.api.nvim_create_augroup("lualine_augroup", { clear = true }),
    pattern = "LspProgressStatusUpdated",
    callback = function()
      require("lualine").refresh()
    end,
  })
end

-- Commit leetcode changes on neovim leave
M.leetcode_autocmd = function(callback)
  vim.api.nvim_create_autocmd("VimLeavePre", {
    group = vim.api.nvim_create_augroup("AutoGitCommit", { clear = true }),
    callback = callback,
  })
end

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function(opts)
    if opts.file:match("dap%-terminal") then
      return
    end
    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.cmd("startinsert")
  end,
})

return M
