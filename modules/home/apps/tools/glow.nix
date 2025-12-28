{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.tools.glow;
in
{
  options.features.apps.tools.glow = {
    enable = lib.mkEnableOption "Glow tool";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.glow ];
  };
}
