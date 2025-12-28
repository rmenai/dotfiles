{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.tools.jc;
in
{
  options.features.apps.tools.jc = {
    enable = lib.mkEnableOption "JC (JSON Convert)";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.jc ];
  };
}
