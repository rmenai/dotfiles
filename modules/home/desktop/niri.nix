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
      hyprpicker
      libnotify
      nautilus

      networkmanager_dmenu
      rofi-power-menu
      rofi-bluetooth
    ];

    programs = {
      fuzzel.enable = true;
      rofi.enable = true;

      waybar = {
        systemd = {
          enable = true;
          target = "graphical-session.target";
        };
      };

      swaylock = {
        enable = true;
        package = pkgs.swaylock-effects;

        settings = {
          daemonize = true;
          show-failed-attempts = true;
          ignore-empty-password = true;
          grace-no-touch = true;
          grace = 0;

          screenshots = true;
          effect-blur = "15x15";
          effect-vignette = "1:1";

          clock = true;
          indicator = true;
          indicator-radius = 160;
          indicator-thickness = 20;

          font = "Iosevka Nerd Font Mono";
          datestr = "%a, %B %e";

          ring-color = lib.mkForce "b4befe"; # #b4befe
          inside-color = lib.mkForce "1e1e2e80"; # #1e1e2e
          key-hl-color = lib.mkForce "11111b80"; # #11111b
          text-caps-lock-color = lib.mkForce "b4befe"; # #b4befe

          ring-wrong-color = lib.mkForce "f38ba8"; # #f38ba8
          text-wrong-color = lib.mkForce "f38ba8"; # #f38ba8

          ring-ver-color = lib.mkForce "cba6f7"; # #cba6f7
          text-ver-color = lib.mkForce "cba6f7"; # #cba6f7

          ring-clear-color = lib.mkForce "f2cdcd"; # #f2cdcd
          text-clear-color = lib.mkForce "f2cdcd"; # #f2cdcd
          bs-hl-color = lib.mkForce "f2cdcd"; # #f2cdcd
        };
      };

      satty = {
        enable = true;

        settings = {
          general = {
            fullscreen = true;
            early-exit = true;
            initial-tool = "brush";
            copy-command = "wl-copy";
            output-filename = "~/Pictures/Drafts/%Y-%m-%d_%H:%M:%S.png";
            save-after-copy = true;
            primary-highlighter = "block";
            no-window-decoration = true;
          };

          font = {
            family = "Roboto";
            style = "Regular";
          };

          "color-palette" = {
            palette = [
              "#b4befe" # Lavender
              "#f38ba8" # Red
              "#fab387" # Peach
              "#f9e2af" # Yellow
              "#a6e3a1" # Green
              "#89b4fa" # Blue
              "#cba6f7" # Mauve
            ];
          };
        };
      };
    };

    services = {
      cliphist = {
        enable = true;
        systemdTargets = [ "graphical-session.target" ];
      };

      swww = {
        enable = true;
      };

      swayidle = {
        enable = true;
        systemdTarget = "graphical-session.target";

        extraArgs = [ "-w" ];

        events = {
          "lock" = "${pkgs.swaylock-effects}/bin/swaylock -f";
          "before-sleep" = "${pkgs.systemd}/bin/loginctl lock-session";
        };

        timeouts = [
          # 2.5 Minutes: Dim screen
          {
            timeout = 150;
            command = "${pkgs.brightnessctl}/bin/brightnessctl -s set 10"; # Save state and dim
            resumeCommand = "${pkgs.brightnessctl}/bin/brightnessctl -r"; # Restore state
          }

          # 5 Minutes: Lock screen
          {
            timeout = 300;
            command = "${pkgs.systemd}/bin/loginctl lock-session";
          }

          # 5.5 Minutes: Turn off screens
          {
            timeout = 330;
            command = "niri msg action power-off-monitors";
          }
        ];
      };

      swaync = {
        enable = true;

        settings = {
          timeout = 5;
          timeout-low = 3;
          timeout-critical = 0;
          fit-to-screen = true;
          keyboard-shortcuts = true;
          notification-2fa-action = true; # Handy for "Copy 2FA code" buttons

          widgets = [
            "title"
            "dnd"
            "notifications"
          ];

          widget-config = {
          };
        };
      };

      swayosd = {
        enable = true;
        topMargin = 0.03;
      };

      wlsunset = {
        enable = true;
        systemdTarget = "graphical-session.target";

        # France, Lyon
        longitude = "45.7";
        latitude = "4.9";

        temperature.day = 6500;
        temperature.night = 6000;
      };
    };

    catppuccin = {
      rofi.enable = true;
      swaync.enable = true;
      swaylock.enable = true;
    };

    # Niri is enabled by the nixos module
    programs.niri = {
      settings = {
        prefer-no-csd = true;
        screenshot-path = "~/Pictures/Screenshots/%Y-%m-%d_%H:%M:%S.png";

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
            enable = true;
            width = 4;
            active.color = "#0f0f1a99";
            inactive.color = "#00000000";
          };

          border = {
            enable = false;
          };

          shadow = {
            enable = false;
            softness = 20;
            spread = 5;
            color = "#1e1e2e80";
          };
        };

        spawn-at-startup = [
          { argv = [ "xwayland-satellite" ]; }
        ];

        window-rules = [
          {
            geometry-corner-radius = {
              top-left = 0.0;
              top-right = 0.0;
              bottom-right = 12.0;
              bottom-left = 12.0;
            };

            clip-to-geometry = true;
          }
        ];

        binds =
          with config.lib.niri.actions;
          let
            sh = spawn "sh" "-c";
          in
          {
            # ========================================
            # 1. System & Applications
            # ========================================
            "Mod+Shift+Slash".action = show-hotkey-overlay;
            "Mod+T".action = spawn "foot";
            "Mod+D".action = spawn "rofi" "-show" "drun";
            "Mod+N".action = spawn "swaync-client" "-t" "-sw";
            "Mod+V".action =
              spawn "sh" "-c"
                "cliphist list | rofi -dmenu -p 'Clipboard' | cliphist decode | wl-copy";

            "Super+Alt+L".action = spawn "swaylock";

            # Toggle Orca (Screen Reader)
            "Super+Alt+S" = {
              allow-when-locked = true;
              action = sh "pkill orca || exec orca";
            };

            "Super+Shift+C" = {
              allow-when-locked = true;
              action = sh "hyprpicker -a";
            };

            # ========================================
            # 2. Audio & Media (Allow when locked)
            # ========================================
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
            "XF86AudioNext" = {
              allow-when-locked = true;
              action = spawn "swayosd-client" "--playerctl" "next";
            };
            "XF86AudioPrev" = {
              allow-when-locked = true;
              action = sh "playerctl previous";
            };
            "XF86AudioStop" = {
              allow-when-locked = true;
              action = sh "playerctl stop";
            };

            # ========================================
            # 3. Brightness
            # ========================================
            "XF86MonBrightnessUp" = {
              allow-when-locked = true;
              action = spawn "swayosd-client" "--brightness" "raise";
            };
            "XF86MonBrightnessDown" = {
              allow-when-locked = true;
              action = spawn "swayosd-client" "--brightness" "lower";
            };

            # ========================================
            # 4. Window & Overview Management
            # ========================================
            "Mod+O" = {
              repeat = false;
              action = toggle-overview;
            };
            "Mod+Q" = {
              repeat = false;
              action = close-window;
            };

            # ========================================
            # 5. Focus Movement (Arrow Keys & Vim)
            # ========================================
            "Mod+Left".action = focus-column-left;
            "Mod+Down".action = focus-window-down;
            "Mod+Up".action = focus-window-up;
            "Mod+Right".action = focus-column-right;
            "Mod+H".action = focus-column-left;
            "Mod+J".action = focus-window-down;
            "Mod+K".action = focus-window-up;
            "Mod+L".action = focus-column-right;

            "Mod+Home".action = focus-column-first;
            "Mod+End".action = focus-column-last;

            # ========================================
            # 6. Window/Column Movement
            # ========================================
            "Mod+Ctrl+Left".action = move-column-left;
            "Mod+Ctrl+Down".action = move-window-down;
            "Mod+Ctrl+Up".action = move-window-up;
            "Mod+Ctrl+Right".action = move-column-right;
            "Mod+Ctrl+H".action = move-column-left;
            "Mod+Ctrl+J".action = move-window-down;
            "Mod+Ctrl+K".action = move-window-up;
            "Mod+Ctrl+L".action = move-column-right;

            "Mod+Ctrl+Home".action = move-column-to-first;
            "Mod+Ctrl+End".action = move-column-to-last;

            # ========================================
            # 7. Monitor Focus (Shift)
            # ========================================
            "Mod+Shift+Left".action = focus-monitor-left;
            "Mod+Shift+Down".action = focus-monitor-down;
            "Mod+Shift+Up".action = focus-monitor-up;
            "Mod+Shift+Right".action = focus-monitor-right;
            "Mod+Shift+H".action = focus-monitor-left;
            "Mod+Shift+J".action = focus-monitor-down;
            "Mod+Shift+K".action = focus-monitor-up;
            "Mod+Shift+L".action = focus-monitor-right;

            # ========================================
            # 8. Move Column to Monitor (Ctrl+Shift)
            # ========================================
            "Mod+Shift+Ctrl+Left".action = move-column-to-monitor-left;
            "Mod+Shift+Ctrl+Down".action = move-column-to-monitor-down;
            "Mod+Shift+Ctrl+Up".action = move-column-to-monitor-up;
            "Mod+Shift+Ctrl+Right".action = move-column-to-monitor-right;
            "Mod+Shift+Ctrl+H".action = move-column-to-monitor-left;
            "Mod+Shift+Ctrl+J".action = move-column-to-monitor-down;
            "Mod+Shift+Ctrl+K".action = move-column-to-monitor-up;
            "Mod+Shift+Ctrl+L".action = move-column-to-monitor-right;

            # ========================================
            # 9. Workspace Movement (PageUp/Down/U/I)
            # ========================================
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

            # ========================================
            # 10. Mouse Wheel Bindings (with Cooldown)
            # ========================================
            "Mod+WheelScrollDown" = {
              cooldown-ms = 150;
              action = focus-workspace-down;
            };
            "Mod+WheelScrollUp" = {
              cooldown-ms = 150;
              action = focus-workspace-up;
            };
            "Mod+Ctrl+WheelScrollDown" = {
              cooldown-ms = 150;
              action = move-column-to-workspace-down;
            };
            "Mod+Ctrl+WheelScrollUp" = {
              cooldown-ms = 150;
              action = move-column-to-workspace-up;
            };

            "Mod+WheelScrollRight".action = focus-column-right;
            "Mod+WheelScrollLeft".action = focus-column-left;
            "Mod+Ctrl+WheelScrollRight".action = move-column-right;
            "Mod+Ctrl+WheelScrollLeft".action = move-column-left;

            "Mod+Shift+WheelScrollDown".action = focus-column-right;
            "Mod+Shift+WheelScrollUp".action = focus-column-left;
            "Mod+Ctrl+Shift+WheelScrollDown".action = move-column-right;
            "Mod+Ctrl+Shift+WheelScrollUp".action = move-column-left;

            # ========================================
            # 11. Workspaces 1-9
            # ========================================
            "Mod+1".action = focus-workspace 1;
            "Mod+2".action = focus-workspace 2;
            "Mod+3".action = focus-workspace 3;
            "Mod+4".action = focus-workspace 4;
            "Mod+5".action = focus-workspace 5;
            "Mod+6".action = focus-workspace 6;
            "Mod+7".action = focus-workspace 7;
            "Mod+8".action = focus-workspace 8;
            "Mod+9".action = focus-workspace 9;

            # "Mod+Ctrl+1".action = move-column-to-workspace 1;
            # "Mod+Ctrl+2".action = move-column-to-workspace 2;
            # "Mod+Ctrl+3".action = move-column-to-workspace 3;
            # "Mod+Ctrl+4".action = move-column-to-workspace 4;
            # "Mod+Ctrl+5".action = move-column-to-workspace 5;
            # "Mod+Ctrl+6".action = move-column-to-workspace 6;
            # "Mod+Ctrl+7".action = move-column-to-workspace 7;
            # "Mod+Ctrl+8".action = move-column-to-workspace 8;
            # "Mod+Ctrl+9".action = move-column-to-workspace 9;

            # ========================================
            # 12. Column & Window Resizing/Layout
            # ========================================
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

            # Toggle Floating / Tiling
            # "Mod+V".action = toggle-window-floating;
            "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;

            # Toggle Tabbed Mode
            "Mod+W".action = toggle-column-tabbed-display;

            # ========================================
            # 13. Screenshots
            # ========================================
            "Print".action = {
              screenshot = [ ];
            };

            "Ctrl+Print".action = {
              screenshot-screen = [ ];
            };

            "Alt+Print".action = {
              screenshot-window = [ ];
            };

            "XF86Cut" = {
              action = spawn "sh" "-c" "wl-paste | satty --filename -";
            };

            # ========================================
            # 14. Session Control
            # ========================================
            "Mod+Escape" = {
              allow-inhibiting = false;
              action = toggle-keyboard-shortcuts-inhibit;
            };
            "Mod+Shift+E".action = quit;
            "Ctrl+Alt+Delete".action = quit;
            "Mod+Shift+P".action = power-off-monitors;
          };
      };
    };
  };
}
