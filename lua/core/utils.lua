local M = {}

M.get_cmakefile = function()
  local cwd = vim.fn.getcwd()
  return vim.fs.find("CMakeLists.txt", { upward = true, type = "file", path = cwd })[1]
end

M.read_json = function(filepath)
  local file = io.open(filepath, "r")
  if not file then
    return nil
  end

  local content = file:read("*a")
  file:close()
  return vim.fn.json_decode(content)
end

M.slugify = function(title)
  local slug = title:lower()

  slug = slug:gsub("[^%w%s%-]", "")
  slug = slug:gsub("%s+", "-")
  slug = slug:gsub("-+", "-")
  return slug
end

M.truncate_filename = function(filename, max_len)
  if #filename > max_len then
    return "..." .. string.sub(filename, -max_len + 3)
  end
  return filename
end

M.run_cmd = function(cmd)
  local handle = io.popen(cmd)
  if not handle then
    return nil, "Failed to execute command"
  end

  local result = handle:read("*a")
  handle:close()
  return result
end

M.count_changed_files = function(dir)
  local status_output = M.run_cmd("git -C " .. dir .. " status --short")
  if not status_output then
    return 0
  end
  local file_count = 0
  for _ in status_output:gmatch("[^\r\n]+") do
    file_count = file_count + 1
  end
  return file_count
end

M.sync_repo = function(dir, repo)
  if vim.fn.isdirectory(dir) == 0 then
    vim.cmd("!git clone " .. repo .. " " .. dir)
  else
    -- Pull the latest changes from the remote repo
    vim.cmd("!git -C " .. dir .. " pull --rebase")

    local file_count = M.count_changed_files(dir)

    if file_count > 0 then
      vim.cmd("!git -C " .. dir .. " add .")
      vim.cmd("!git -C " .. dir .. ' commit -m "Auto sync leetcode"')
      vim.cmd("!git -C " .. dir .. " push")
    end
  end
end

return M
