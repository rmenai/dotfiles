local wt = require("wezterm")
local Config = require("utils.class.config"):new()

require("events.update-status")
require("events.augment-command-palette")

Config:add("config")
Config:add("mappings")

-- Plugins
local smart_splits_plugin = wt.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
smart_splits_plugin.apply_to_config(Config, {
  default_amount = 2,
  direction_keys = { "h", "j", "k", "l" },
  modifiers = {
    move = "CTRL",
    resize = "META",
  },
  log_level = "info",
})

return Config
