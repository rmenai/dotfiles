{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.gaming.mango;
in
{
  options.features.apps.gaming.mango = {
    enable = lib.mkEnableOption "MangoHUD";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.mangohud ];
    catppuccin.mangohud.enable = true;
  };
}
