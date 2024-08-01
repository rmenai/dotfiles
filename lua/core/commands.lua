local function CommitCurrentFile()
  local file_path = vim.fn.expand("%:p") -- Get the full path of the current file
  if file_path == "" then
    print("No file is currently open")
    return
  end

  local commit_message = "Update " .. vim.fn.expand("%:t")

  vim.cmd("w") -- Save current file
  vim.cmd("!git add " .. file_path)
  vim.cmd("!git commit -m '" .. commit_message .. "' " .. file_path)
end

local function ObsidianCreateWithDefault()
  local obsidian = require("obsidian").get_client()
  local utils = require("obsidian.util")

  if not obsidian:templates_dir() then
    return
  end

  local title = utils.input("Enter title or path (optional): ")
  if not title then
    return
  elseif title == "" then
    title = nil
  end

  local note = obsidian:create_note({ title = title, no_write = false, template = "default" })
  if not note then
    return
  end

  obsidian:open_note(note, { sync = true })
end

local function ObsidianCreateWithTemplate()
  local obsidian = require("obsidian").get_client()
  local utils = require("obsidian.util")

  if not obsidian:templates_dir() then
    return
  end

  local title = utils.input("Enter title or path (optional): ")
  if not title then
    return
  elseif title == "" then
    title = nil
  end

  local picker = obsidian:picker()
  if not picker then
    return
  end

  picker:find_templates({
    callback = function()
      local note = obsidian:create_note({ title = title, no_write = false, template = "default" })
      if not note then
        return
      end

      obsidian:open_note(note, { sync = true })
    end
  })
end


vim.api.nvim_create_user_command("CommitCurrentFile", CommitCurrentFile, {})
vim.api.nvim_create_user_command("ObsidianCreate", ObsidianCreateWithDefault, {})
vim.api.nvim_create_user_command("ObsidianCreateWithTemplate", ObsidianCreateWithTemplate, {})
