{ config, lib, ... }:
let
  cfg = config.features.desktop.void;
in
{
  config = lib.mkIf cfg.enable {
    programs.niri.settings.window-rules = [
      {
        clip-to-geometry = true;

        geometry-corner-radius = {
          top-left = 0.0;
          top-right = 0.0;
          bottom-right = 12.0;
          bottom-left = 12.0;
        };
      }

      {
        matches = [ { title = "Vivaldi"; } ];
        open-maximized = true;
      }
    ];
  };
}
