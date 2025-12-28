local wt = require("wezterm")

wt.on("smart_workspace_switcher.workspace_switcher.created", function(window, workspace_name)
  local pane = window:active_pane()

  if pane then
    local current_dir_uri = pane:get_current_working_dir()

    if current_dir_uri then
      local current_dir = current_dir_uri.file_path
      local project_config_path = current_dir .. ".wezterm.lua"
      local f = io.open(project_config_path, "r")
      if f then
        f:close()

        local ok, err = pcall(dofile, project_config_path)
        if not ok then
          wt.log_error("Error loading project config " .. project_config_path .. ": " .. tostring(err))
        else
          wt.log_info("Loaded project config: " .. project_config_path)
        end
      end
    end
  end
end)
