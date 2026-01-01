{
  config,
  lib,
  ...
}:
let
  cfg = config.features.apps.gaming.lutris;
in
{
  options.features.apps.gaming.lutris = {
    enable = lib.mkEnableOption "Lutris gaming platform";
  };

  config = lib.mkIf cfg.enable {
    programs.lutris.enable = true;
  };
}
