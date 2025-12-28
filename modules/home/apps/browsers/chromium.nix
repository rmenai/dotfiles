{ config, lib, ... }:
let
  cfg = config.features.apps.browsers.chromium;
in
{
  options.features.apps.browsers.chromium = {
    enable = lib.mkEnableOption "Chromium browser";
  };

  config = lib.mkIf cfg.enable {
    programs.chromium.enable = true;
    catppuccin.chromium.enable = true;
  };
}
