{
  config,
  lib,
  ...
}:
let
  cfg = config.features.apps.gaming.mangohud;
in
{
  options.features.apps.gaming.mangohud = {
    enable = lib.mkEnableOption "MangoHUD";
  };

  config = lib.mkIf cfg.enable {
    programs.mangohud = {
      enable = true;
    };

    catppuccin.mangohud.enable = true;
  };
}
