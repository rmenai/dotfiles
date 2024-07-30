function AutoCommitCurrentFile()
  local file_path = vim.fn.expand("%:p")  -- Get the full path of the current file
  if file_path == "" then
    print('No file is currently open.')
    return
  end

  local commit_message = "Add " .. vim.fn.expand('%:t')

  -- Staging the current file
  os.execute("git add " .. file_path)
  vim.cmd("!git commit -m '" .. commit_message .. "' " .. file_path)
end
