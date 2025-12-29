{ config, lib, ... }:
let
  cfg = config.features.desktop.void;
in
{
  config = lib.mkIf cfg.enable {
    programs.niri = {
      settings = {
        prefer-no-csd = true;
        screenshot-path = "~/Pictures/Screenshots/%Y-%m-%d_%H:%M:%S.png";
        hotkey-overlay.skip-at-startup = true;
        overview.backdrop-color = "#11111b";

        spawn-at-startup = [
          { argv = [ "xwayland-satellite" ]; }
        ];

        # Run niri msg outputs
        outputs."eDP-1" = {
          scale = 1.5;

          mode = {
            width = 3072;
            height = 1920;
            refresh = 120.002;
          };
        };

        input = {
          focus-follows-mouse.enable = true;
          workspace-auto-back-and-forth = true;

          touchpad = {
            tap = true;
            dwt = true;
            scroll-factor = 0.4;
            natural-scroll = true;
          };
        };

        # recent-windows = {
        #   enable = true;
        # };

        layout = {
          gaps = 4;

          center-focused-column = "never";
          always-center-single-column = true;

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

          shadow = {
            enable = false;
            softness = 20;
            spread = 5;
            color = "#1e1e2e80";
          };

          border = {
            enable = false;
          };
        };
      };
    };
  };
}
