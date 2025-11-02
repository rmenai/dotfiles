local wt = require("wezterm")
local Config = {}

Config.adjust_window_size_when_changing_font_size = false
Config.allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace"
Config.anti_alias_custom_block_glyphs = true

Config.font_size = 12.0

Config.font = wt.font_with_fallback({
  {
    family = "FiraCode Nerd Font",
    weight = "Regular",
  },
  { family = "JetBrains Mono Nerd Font" },
  { family = "Noto Sans CJK JP" },
  { family = "Noto Color Emoji" },
  { family = "LegacyComputing" },
})

return Config
