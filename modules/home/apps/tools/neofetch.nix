{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.tools.neofetch;
in
{
  options.features.apps.tools.neofetch = {
    enable = lib.mkEnableOption "Neofetch";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.neofetch ];
  };
}
