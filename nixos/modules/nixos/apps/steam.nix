{ config, lib, ... }:
let
  cfg = config.features.apps.steam;
in
{
  options.features.apps.steam.enable = lib.mkEnableOption "Steam";

  config = lib.mkIf cfg.enable {
    programs.steam.enable = true;
    hardware.graphics.enable = true;
  };
}
