{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.desktop.niri;
in
{
  options.features.desktop.niri = {
    enable = lib.mkEnableOption "niri";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      wl-clipboard
      alacritty
      cliphist
      matugen
      cava
    ];

    programs.fuzzel.enable = true;

    # Niri is enabled by the nixos module
    programs.niri = {
      settings = {
        input = {
          keyboard.xkb.layout = "us";
          mouse.natural-scroll = false;

          touchpad = {
            tap = true;
            natural-scroll = true;
          };
        };

        outputs."eDP-1" = {
          scale = 1.5;
        };

        layout = {
          gaps = 4;
          center-focused-column = "never";

          preset-column-widths = [
            { proportion = 1.0 / 3.0; }
            { proportion = 1.0 / 2.0; }
            { proportion = 2.0 / 3.0; }
          ];

          default-column-width = {
            proportion = 0.5;
          };

          focus-ring = {
            enable = false;
            width = 4;
            active.color = "#b4befe";
            inactive.color = "#505050";
          };

          border = {
            enable = false;
          };
        };

        spawn-at-startup = [
          { argv = [ "waybar" ]; }
          { argv = [ "xwayland-satellite" ]; }
        ];

        window-rules = [
          {
            matches = [ { app-id = "^org\\.wezfurlong\\.wezterm$"; } ];
            default-column-width = { };
          }
          {
            # Make Firefox PiP floating
            matches = [
              {
                app-id = "firefox$";
                title = "^Picture-in-Picture$";
              }
            ];
            open-floating = true;
          }
        ];

        binds =
          with config.lib.niri.actions;
          let
            sh = spawn "sh" "-c";
          in
          {
            # Workspace switching (1-9)
            "Mod+1".action.focus-workspace = 1;
            "Mod+2".action.focus-workspace = 2;
            "Mod+3".action.focus-workspace = 3;
            "Mod+4".action.focus-workspace = 4;
            "Mod+5".action.focus-workspace = 5;
            "Mod+6".action.focus-workspace = 6;
            "Mod+7".action.focus-workspace = 7;
            "Mod+8".action.focus-workspace = 8;
            "Mod+9".action.focus-workspace = 9;

            # Move window to workspace (Ctrl + 1-9)
            "Mod+Ctrl+1".action.move-column-to-workspace = 1;
            "Mod+Ctrl+2".action.move-column-to-workspace = 2;
            "Mod+Ctrl+3".action.move-column-to-workspace = 3;
            "Mod+Ctrl+4".action.move-column-to-workspace = 4;
            "Mod+Ctrl+5".action.move-column-to-workspace = 5;
            "Mod+Ctrl+6".action.move-column-to-workspace = 6;
            "Mod+Ctrl+7".action.move-column-to-workspace = 7;
            "Mod+Ctrl+8".action.move-column-to-workspace = 8;
            "Mod+Ctrl+9".action.move-column-to-workspace = 9;

            # System
            "Mod+Shift+Slash".action = show-hotkey-overlay;
            "Mod+Shift+E".action = quit;
            "Mod+Shift+P".action = power-off-monitors;

            # Apps
            "Mod+T".action = spawn "wezterm"; # Changed to match your installed app
            "Mod+D".action = spawn "fuzzel";
            "Super+Alt+L".action = spawn "swaylock";

            # Window Management
            "Mod+Q".action = close-window;
            "Mod+O".action = toggle-overview;

            # Movement (Vim keys)
            "Mod+H".action = focus-column-left;
            "Mod+J".action = focus-window-down;
            "Mod+K".action = focus-window-up;
            "Mod+L".action = focus-column-right;

            "Mod+Ctrl+H".action = move-column-left;
            "Mod+Ctrl+J".action = move-window-down;
            "Mod+Ctrl+K".action = move-window-up;
            "Mod+Ctrl+L".action = move-column-right;

            # Monitor Focus
            "Mod+Shift+H".action = focus-monitor-left;
            "Mod+Shift+L".action = focus-monitor-right;

            # Volume / Media (Requires wpctl and playerctl packages)
            "XF86AudioRaiseVolume".action = sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+";
            "XF86AudioLowerVolume".action = sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
            "XF86AudioMute".action = sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

            # Screenshots
            "Print".action = {
              screenshot = [ ];
            };
            "Ctrl+Print".action = {
              screenshot-screen = [ ];
            };
            "Alt+Print".action = {
              screenshot-window = [ ];
            };
          };
      };
    };
  };
}
