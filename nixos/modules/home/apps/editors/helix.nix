{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.editors.helix;
in
{
  options.features.apps.editors.helix = {
    enable = lib.mkEnableOption "Helix text editor";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.helix ];
  };
}
