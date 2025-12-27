local M = {}

--- Internal Zellij Navigation Logic
local function nav(short_direction, direction, action)
  action = action or "move-focus"

  local is_snacks = vim.bo.filetype == "snacks_picker_list"

  -- Pickers are isolated; wincmd h won't escape them to Zellij naturally.
  if is_snacks and short_direction == "h" then
    vim.fn.system("zellij action " .. action .. " " .. direction)
    return
  end

  -- Try Neovim first, then Zellij
  local cur_winnr = vim.fn.winnr()
  vim.api.nvim_command("wincmd " .. short_direction)
  local new_winnr = vim.fn.winnr()

  -- If window ID didn't change, we are at the edge of Neovim
  if cur_winnr == new_winnr then
    vim.fn.system("zellij action " .. action .. " " .. direction)
    if vim.v.shell_error ~= 0 then vim.notify("Zellij executable not found", vim.log.levels.ERROR) end
  end
end

--- Setup function to register all commands
function M.setup()
  local nav_cmds = {
    NavigateUp = function() nav("k", "up") end,
    NavigateDown = function() nav("j", "down") end,
    NavigateLeft = function() nav("h", "left") end,
    NavigateRight = function() nav("l", "right") end,
    NavigateLeftTab = function() nav("h", "left", "move-focus-or-tab") end,
    NavigateRightTab = function() nav("l", "right", "move-focus-or-tab") end,
  }

  for name, func in pairs(nav_cmds) do
    vim.api.nvim_create_user_command(name, func, {})
  end
end

M.setup()

return M
