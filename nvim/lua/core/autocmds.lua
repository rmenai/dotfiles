vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function(opts)
    if opts.file:match("dap%-terminal") then return end
    if opts.file:match("Neotest Output Panel") then return end
    vim.notify("Terminal opened: " .. opts.file, vim.log.levels.INFO)

    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.wo.signcolumn = "no"
    vim.wo.foldcolumn = "1"

    vim.cmd("startinsert")
  end,
})

vim.api.nvim_create_autocmd("WinClosed", {
  pattern = "*",
  callback = function(e)
    local closed_win_id = tonumber(e.match)
    local buffer = vim.fn.getwininfo(closed_win_id)[1].bufnr
    local buf_name = vim.api.nvim_buf_get_name(buffer)

    if not vim.startswith(buf_name, "term://") then return end

    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)
      local filetype = vim.api.nvim_buf_get_option(buf, "filetype")

      if filetype ~= "NvimTree" then
        vim.api.nvim_set_current_win(win) -- Focus this window
        return
      end
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "QuitPre" }, {
  nested = false,
  callback = function(_)
    local filetype = vim.bo.filetype
    if filetype ~= "rust" then return end

    local filepath = vim.fn.expand("%:p")
    if not string.find(filepath, "codeforces") then return end

    if vim.b.file_opened then return end
    vim.b.file_opened = true

    local file_contents = vim.fn.readfile(filepath)
    local contains_solutions = false
    for _, line in ipairs(file_contents) do
      if string.match(line, "fn%s+solve") then
        contains_solutions = true
        break
      end
    end

    if not contains_solutions then return end
    vim.cmd("normal! @c")
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "QuitPre" }, {
  nested = false,
  callback = function(_)
    local filetype = vim.bo.filetype
    if filetype ~= "rust" then return end

    local filepath = vim.fn.expand("%:p")
    if not string.find(filepath, "aoc") then return end

    if vim.b.file_opened then return end
    vim.b.file_opened = true

    local file_contents = vim.fn.readfile(filepath)
    local contains_solutions = false
    for _, line in ipairs(file_contents) do
      if string.match(line, "fn%s+part_one") then
        contains_solutions = true
        break
      end
    end

    if not contains_solutions then return end
    vim.cmd("normal! @v")
  end,
})

vim.api.nvim_create_augroup("NoAutoComment", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = "NoAutoComment",
  pattern = "*",
  command = "setlocal formatoptions-=cro",
})

vim.api.nvim_create_augroup("CleanupNeogitStatus", { clear = true })

vim.api.nvim_create_autocmd("BufWinLeave", {
  group = "CleanupNeogitStatus",
  pattern = "*",
  callback = function(args)
    if vim.bo[args.buf].filetype ~= "NeogitStatus" then return end

    local cmd = vim.v.argv
    local launched_with_only_neogit = #args == 0 and vim.tbl_contains(cmd, "+Neogit")

    if not launched_with_only_neogit then return end

    vim.schedule(function() vim.cmd("q!") end)
  end,
})

vim.api.nvim_create_augroup("NvimTreeRefresh", { clear = true })
vim.api.nvim_create_autocmd("User", {
  group = "NvimTreeRefresh",
  pattern = {
    "NeogitCommitComplete",
    "NeogitPushComplete",
    "NeogitPullComplete",
    "NeogitFetchComplete",
    "NeogitBranchCheckout",
  },
  callback = function()
    local success, nvim_tree_api = pcall(require, "nvim-tree.api")
    if success then nvim_tree_api.tree.reload() end
  end,
})
