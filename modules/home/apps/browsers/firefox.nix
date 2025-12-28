{ config, lib, ... }:
let
  cfg = config.features.apps.browsers.firefox;
in
{
  options.features.apps.browsers.firefox = {
    enable = lib.mkEnableOption "Firefox browser";
  };

  config = lib.mkIf cfg.enable {
    programs.firefox.enable = true;
    catppuccin.firefox.enable = true;
  };
}
