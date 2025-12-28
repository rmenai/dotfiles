{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.tools.direnv;
in
{
  options.features.apps.tools.direnv = {
    enable = lib.mkEnableOption "Direnv and Devenv";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      devenv
      direnv
    ];
  };
}
