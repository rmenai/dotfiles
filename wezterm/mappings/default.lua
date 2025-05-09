---@diagnostic disable-next-line: undefined-field
local act = require("wezterm").action
local key = require("utils.fn").key
local wt = require("wezterm")

local Config = {}

Config.disable_default_key_bindings = true
Config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 750 }

local workspace_switcher_path = "file://" .. wt.config_dir .. "/plugins/smart_workspace_switcher.wezterm"
local success, workspace_switcher = pcall(wt.plugin.require, workspace_switcher_path)
if not success then
  wt.log_error("Failed to load smart_workspace_switcher plugin from: " .. workspace_switcher_path)
  workspace_switcher = {
    switch_to_prev_workspace = function()
      wt.log_error("smart_workspace_switcher not loaded: switch_to_prev_workspace is a no-op")
      return act.NoOp
    end,
    switch_workspace = function()
      wt.log_error("smart_workspace_switcher not loaded: switch_workspace is a no-op")
      return act.NoOp
    end,
  }
end

local mappings = {
  -- == Existing Non-Leader Bindings (Review and prune as desired) ==
  { "<C-S-c>", act.CopyTo("Clipboard"), "copy" },
  { "<C-S-v>", act.PasteFrom("Clipboard"), "paste" },
  { "<C-S-k>", act.ClearScrollback("ScrollbackOnly"), "clear scrollback" },
  {
    "<C-S-u>",
    act.CharSelect({
      copy_on_select = true,
      copy_to = "ClipboardAndPrimarySelection",
    }),
    "char select",
  },
  { "<PageUp>", act.ScrollByPage(-1), "scroll page up" },
  { "<PageDown>", act.ScrollByPage(1), "scroll page down" },
  { "<C-S-Insert>", act.PasteFrom("PrimarySelection"), "paste from primary selection" },
  { "<C-Insert>", act.CopyTo("PrimarySelection"), "copy to primary selection" },

  { "<C-Tab>", act.ActivateTabRelative(1), "next tab (default-like)" },
  { "<C-S-Tab>", act.ActivateTabRelative(-1), "previous tab (default-like)" },

  { "<C-Minus>", act.DecreaseFontSize, "decrease font size (default-like)" },
  { "<C-=>", act.IncreaseFontSize, "increase font size (default-like)" },
  { "<C-0>", act.ResetFontSize, "reset font size (default-like)" },

  -- == Leader Key Table Activators (Your existing setup - unchanged) ==
  { "<leader>h", act.ActivateKeyTable({ name = "help_mode", one_shot = true }), "help mode" },
  { "<leader>w", act.ActivateKeyTable({ name = "window_mode", one_shot = false }), "window management mode" },
  { "<leader>f", act.ActivateKeyTable({ name = "font_mode", one_shot = false }), "font management mode" },
  { "<leader>y", act.ActivateCopyMode, "activate copy mode" },
  { "<leader>P", act.ActivateKeyTable({ name = "pick_mode" }), "activate pick mode" },

  -- Search Mode
  { "<leader>/", act.Search("CurrentSelectionOrEmptyString"), "activate search mode" }, -- Changed from <leader>s

  -- Pane Management (using s and v as requested)
  { "<leader>s", act.SplitVertical({ domain = "CurrentPaneDomain" }), "split pane vertically (new pane to the right, like Neovim <Leader>v)" },
  { "<leader>v", act.SplitHorizontal({ domain = "CurrentPaneDomain" }), "split pane horizontally (new pane below, like Neovim <Leader>s)" },
  { "<leader>x", act.CloseCurrentPane({ confirm = false }), "close current pane" },
  { "<leader>z", act.TogglePaneZoomState, "toggle pane zoom" },

  -- Tab Management
  { "<leader>c", act.SpawnTab("CurrentPaneDomain"), "new tab" },
  { "<leader>Q", act.CloseCurrentTab({ confirm = false }), "close current tab" },
  { "<leader>q", act.CloseCurrentTab({ confirm = true }), "close current tab" },
  {
    "<leader>X",
    wt.action_callback(function(window)
      local mux_window = window:mux_window()
      local count = #mux_window:tabs()

      for _ = 1, count do
        local active_pane = window:active_pane()
        window:perform_action(act.CloseCurrentTab({ confirm = false }), active_pane)
      end
    end),
    "Toggles full screen",
  },
  { "<leader>]", act.ActivateTabRelative(1), "next tab" },
  { "<leader>[", act.ActivateTabRelative(-1), "previous tab" },

  -- Numeric Tab Activation
  { "<leader>1", act.ActivateTab(1), "go to tab 1" },
  { "<leader>2", act.ActivateTab(2), "go to tab 2" },
  { "<leader>3", act.ActivateTab(3), "go to tab 3" },
  { "<leader>4", act.ActivateTab(4), "go to tab 4" },
  { "<leader>5", act.ActivateTab(5), "go to tab 5" },
  { "<leader>6", act.ActivateTab(6), "go to tab 6" },
  { "<leader>7", act.ActivateTab(7), "go to tab 7" },
  { "<leader>8", act.ActivateTab(8), "go to tab 8" },
  { "<leader>9", act.ActivateTab(9), "go to tab 9" },
  { "<leader>0", act.ActivateTab(0), "go to tab 0" },
  { "<leader>Minus", act.ActivateLastTab, "go to last tab" },

  -- Workspace managment
  { "<leader>o", workspace_switcher.switch_workspace(), "switch workspace" },
  { "<leader>p", workspace_switcher.switch_to_prev_workspace(), "go to last workspace" },

  -- Window Management (OS Windows)
  { "<leader>W", act.SpawnWindow, "new OS window" },
  { "<leader>F", act.ToggleFullScreen, "toggle fullscreen" },

  -- Utility
  { "<leader><l>", act.ShowDebugOverlay, "debug overlay" },
  { "<leader>r", act.ReloadConfiguration, "reload configuration" },
  { "<leader> ", act.ActivateCommandPalette, "command palette" },
  { "<leader>Y", act.QuickSelect, "quick select" },

  {
    "<leader><O>",
    act.ShowLauncherArgs({
      title = "  Search:",
      flags = "FUZZY|LAUNCH_MENU_ITEMS|DOMAINS",
    }),
    "show launcher",
  },
  {
    "<leader><a>",
    act.ShowLauncherArgs({
      title = "  Search:",
      flags = "FUZZY|WORKSPACES",
    }),
    "show launcher",
  },

  { "<leader>k", act.ScrollByPage(-1), "scroll page up" },
  { "<leader>j", act.ScrollByPage(1), "scroll page down" },
  { "<leader>K", act.ClearScrollback("ScrollbackOnly"), "clear scrollback" },
}

Config.keys = {}
for _, map_tbl in ipairs(mappings) do
  key.map(map_tbl[1], map_tbl[2], Config.keys)
end

return Config
