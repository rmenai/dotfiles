local Utils = require("utils")
local color = Utils.fn.color
local wt = require("wezterm")

local Config = {}

Config.window_background_opacity = 0.9
Config.default_cursor_style = "SteadyBar"

Config.color_schemes = color.get_schemes()
Config.color_scheme = color.get_scheme()

local theme = Config.color_schemes[Config.color_scheme]

Config.background = {
  {
    source = { Color = theme.background },
    width = "100%",
    height = "100%",
    opacity = Config.window_background_opacity or 1,
  },
}

Config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.8,
}

Config.bold_brightens_ansi_colors = "BrightAndBold"

Config.char_select_bg_color = theme.brights[6]
Config.char_select_fg_color = theme.background
Config.char_select_font_size = 12

Config.command_palette_bg_color = wt.color.parse(theme.brights[6]):desaturate(0.2)
Config.command_palette_fg_color = theme.background
Config.command_palette_font_size = 14
Config.command_palette_rows = 20

Config.cursor_thickness = 1
Config.hide_mouse_cursor_when_typing = true
Config.force_reverse_video_cursor = true

Config.text_blink_ease_in = "EaseIn"
Config.text_blink_ease_out = "EaseOut"
Config.text_blink_rapid_ease_in = "Linear"
Config.text_blink_rapid_ease_out = "Linear"
Config.text_blink_rate = 500
Config.text_blink_rate_rapid = 250

Config.audible_bell = "SystemBeep"
Config.visual_bell = {
  fade_in_function = "EaseOut",
  fade_in_duration_ms = 200,
  fade_out_function = "EaseIn",
  fade_out_duration_ms = 200,
}

Config.window_padding = { left = 10, right = 4, top = 8, bottom = 1 }
Config.integrated_title_button_alignment = "Right"
Config.integrated_title_button_style = "Windows"
Config.integrated_title_buttons = { "Hide", "Maximize", "Close" }

Config.clean_exit_codes = { 130 }
Config.exit_behavior = "Close"
Config.exit_behavior_messaging = "Verbose"
Config.skip_close_confirmation_for_processes_named = {
  "bash",
  "sh",
  "zsh",
  "fish",
  "tmux",
  "nu",
  "cmd.exe",
  "pwsh.exe",
  "powershell.exe",
}

return Config
