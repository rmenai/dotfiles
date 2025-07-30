local M = {}

M.get_cmakefile = function()
  local cwd = vim.fn.getcwd()
  return vim.fs.find("CMakeLists.txt", { upward = true, type = "file", path = cwd })[1]
end

M.read_json = function(filepath)
  local file = io.open(filepath, "r")
  if not file then return nil end

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
  if #filename > max_len then return "..." .. string.sub(filename, -max_len + 3) end
  return filename
end

M.run_cmd = function(cmd)
  local handle = io.popen(cmd)
  if not handle then return nil, "Failed to execute command" end

  local result = handle:read("*a")
  handle:close()
  return result
end

M.count_changed_files = function(dir)
  local status_output = M.run_cmd("git -C " .. dir .. " status --short")
  if not status_output then return 0 end
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

M.is_server_available = function(mason_pkg, binary)
  -- Check if the binary is in the system PATH
  if vim.fn.executable(binary) == 1 then return true end

  -- Check if Mason's registry has the package installed
  local ok, registry = pcall(require, "mason-registry")
  if ok then
    local success, pkg = pcall(registry.get_package, mason_pkg)
    if success and pkg and pkg:is_installed() then return true end
  end

  return false
end

M.get_content = function(opts)
  local content

  -- opts.count will be -1 if no range is given (e.g., called in normal mode without a visual selection)
  if opts.count == -1 then
    -- No range provided, so get the whole buffer
    local all_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    content = table.concat(all_lines, "\n")
    vim.notify("Processed whole buffer.", vim.log.levels.INFO)
  else
    -- Range was provided (from visual selection), so get only those lines
    -- vim.api is 0-indexed, but command ranges are 1-indexed, so we subtract 1.
    local ranged_lines = vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, false)
    content = table.concat(ranged_lines, "\n")
    vim.notify("Processed selection.", vim.log.levels.INFO)
  end

  return content
end

return M
