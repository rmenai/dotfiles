{ config, lib, ... }:
with config.lib.niri.actions;
let
  cfg = config.features.desktop.void;
in
{
  config = lib.mkIf cfg.enable {
    programs.niri.settings.binds = {
      "Mod+Shift+Slash".action = show-hotkey-overlay;
      "Mod+T".action = spawn "foot";
      "Mod+Shift+T".action = spawn "kitty";
      "Mod+D".action = spawn "rofi" "-show" "drun";
      "Mod+Alt+L".action = spawn "swaylock";

      "Mod+O" = {
        repeat = false;
        action = toggle-overview;
      };
      "Mod+Q" = {
        repeat = false;
        action = close-window;
      };

      "Mod+Left".action = focus-column-left-or-last;
      "Mod+Down".action = focus-window-or-workspace-down;
      "Mod+Up".action = focus-window-or-workspace-up;
      "Mod+Right".action = focus-column-right-or-first;

      "Mod+H".action = focus-column-left-or-last;
      "Mod+J".action = focus-window-or-workspace-down;
      "Mod+K".action = focus-window-or-workspace-up;
      "Mod+L".action = focus-column-right-or-first;

      "Mod+Ctrl+Left".action = move-column-left;
      "Mod+Ctrl+Down".action = move-window-down-or-to-workspace-down;
      "Mod+Ctrl+Up".action = move-window-up-or-to-workspace-up;
      "Mod+Ctrl+Right".action = move-column-right;

      "Mod+Ctrl+H".action = move-column-left;
      "Mod+Ctrl+J".action = move-window-down-or-to-workspace-down;
      "Mod+Ctrl+K".action = move-window-up-or-to-workspace-up;
      "Mod+Ctrl+L".action = move-column-right;

      "Mod+Home".action = focus-column-first;
      "Mod+End".action = focus-column-last;
      "Mod+Ctrl+Home".action = move-column-to-first;
      "Mod+Ctrl+End".action = move-column-to-last;

      # "Alt+Tab".action = next-window;
      # "Alt+Shift+Tab".action = previous-window;
      # "Alt+grave".action.next-window.filter = "app-id";
      # "Alt+Shift+grave".action.previous-window.filter = "app-id";
      #
      # "Mod+Tab".action = next-window;
      # "Mod+Shift+Tab".action = previous-window;
      # "Mod+grave".action.next-window.filter = "app-id";
      # "Mod+Shift+grave".action.previous-window.filter = "app-id";

      "Mod+Page_Down".action = focus-workspace-down;
      "Mod+Page_Up".action = focus-workspace-up;
      "Mod+U".action = focus-workspace-down;
      "Mod+I".action = focus-workspace-up;
      "Mod+Ctrl+Page_Down".action = move-column-to-workspace-down;
      "Mod+Ctrl+Page_Up".action = move-column-to-workspace-up;
      "Mod+Ctrl+U".action = move-column-to-workspace-down;
      "Mod+Ctrl+I".action = move-column-to-workspace-up;

      "Mod+Shift+Page_Down".action = move-workspace-down;
      "Mod+Shift+Page_Up".action = move-workspace-up;
      "Mod+Shift+U".action = move-workspace-down;
      "Mod+Shift+I".action = move-workspace-up;

      "Mod+1".action = focus-workspace 1;
      "Mod+2".action = focus-workspace 2;
      "Mod+3".action = focus-workspace 3;
      "Mod+4".action = focus-workspace 4;
      "Mod+5".action = focus-workspace 5;
      "Mod+6".action = focus-workspace 6;
      "Mod+7".action = focus-workspace 7;
      "Mod+8".action = focus-workspace 8;
      "Mod+9".action = focus-workspace 9;
      "Mod+Ctrl+1".action.move-window-to-workspace = 1;
      "Mod+Ctrl+2".action.move-window-to-workspace = 2;
      "Mod+Ctrl+3".action.move-window-to-workspace = 3;
      "Mod+Ctrl+4".action.move-window-to-workspace = 4;
      "Mod+Ctrl+5".action.move-window-to-workspace = 5;
      "Mod+Ctrl+6".action.move-window-to-workspace = 6;
      "Mod+Ctrl+7".action.move-window-to-workspace = 7;
      "Mod+Ctrl+8".action.move-window-to-workspace = 8;
      "Mod+Ctrl+9".action.move-window-to-workspace = 9;

      "Mod+N".action = spawn "swaync-client" "-t" "-sw";
      # "Mod+V".action = spawn-sh "cliphist list | rofi -dmenu -p 'Clipboard' | cliphist decode | wl-copy";
      # "Mod+Shift+C".action = spawn-sh "hyprpicker -a";
      "XF86Cut".action = spawn-sh "wl-paste | satty --filename -";

      "Mod+BracketLeft".action = consume-or-expel-window-left;
      "Mod+BracketRight".action = consume-or-expel-window-right;
      "Mod+Comma".action = consume-window-into-column;
      "Mod+Period".action = expel-window-from-column;

      "Mod+R".action = switch-preset-column-width;
      "Mod+Shift+R".action = switch-preset-window-height;
      "Mod+Ctrl+R".action = reset-window-height;
      "Mod+F".action = maximize-column;
      "Mod+Shift+F".action = fullscreen-window;
      "Mod+Ctrl+F".action = expand-column-to-available-width;

      "Mod+C".action = center-column;
      "Mod+Ctrl+C".action = center-visible-columns;

      "Mod+Minus".action = set-column-width "-10%";
      "Mod+Equal".action = set-column-width "+10%";
      "Mod+Shift+Minus".action = set-window-height "-10%";
      "Mod+Shift+Equal".action = set-window-height "+10%";

      "Mod+V".action = toggle-window-floating;
      "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;
      "Mod+W".action = toggle-column-tabbed-display;

      "Print".action.screenshot = [ ];
      "Ctrl+Print".action.screenshot-screen = [ ];
      "Alt+Print".action.screenshot-window = [ ];

      "Mod+Shift+E".action = quit;
      "Mod+Shift+P".action = power-off-monitors;
      "Mod+Return".action = do-screen-transition;

      "Mod+Escape" = {
        allow-inhibiting = false;
        action = toggle-keyboard-shortcuts-inhibit;
      };

      "XF86AudioRaiseVolume" = {
        allow-when-locked = true;
        action = spawn "swayosd-client" "--output-volume" "raise";
      };
      "XF86AudioLowerVolume" = {
        allow-when-locked = true;
        action = spawn "swayosd-client" "--output-volume" "lower";
      };
      "XF86AudioMute" = {
        allow-when-locked = true;
        action = spawn "swayosd-client" "--output-volume" "mute-toggle";
      };
      "XF86AudioMicMute" = {
        allow-when-locked = true;
        action = spawn "swayosd-client" "--input-volume" "mute-toggle";
      };

      "XF86AudioPlay" = {
        allow-when-locked = true;
        action = spawn "swayosd-client" "--playerctl" "play-pause";
      };
      "XF86AudioStop" = {
        allow-when-locked = true;
        action = spawn "playerctl" "stop";
      };
      "XF86AudioPrev" = {
        allow-when-locked = true;
        action = spawn "playerctl" "previous";
      };
      "XF86AudioNext" = {
        allow-when-locked = true;
        action = spawn "swayosd-client" "--playerctl" "next";
      };

      "XF86MonBrightnessUp" = {
        allow-when-locked = true;
        action = spawn "swayosd-client" "--brightness" "raise";
      };
      "XF86MonBrightnessDown" = {
        allow-when-locked = true;
        action = spawn "swayosd-client" "--brightness" "lower";
      };
    };
  };
}
