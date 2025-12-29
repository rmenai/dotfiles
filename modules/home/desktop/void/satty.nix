{ config, lib, ... }:
let
  cfg = config.features.desktop.void;
in
{
  config = lib.mkIf cfg.enable {
    programs.satty = {
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
}
